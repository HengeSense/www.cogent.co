require 'time'
require 'flickraw'
require 'tilt'

class CustomScssTemplate < Tilt::ScssTemplate

  private

  def sass_options
    options.merge(:filename => eval_file, :line => line, :syntax => :scss, :style => :compact)
  end

end

Tilt.register CustomScssTemplate, 'scss'

# Generate shorter URLs
project.assume_content_negotiation = true
project.assume_directory_index = true

project.helpers do
  def abbreviate_path(path)
    path.to_s.sub(/\.html/, "")
  end

  def nav_link(target_ref, label, options = {})
    target_path = abbreviate_path(target_ref)
    current_path = abbreviate_path(page.output_path)
    selected = (target_path == current_path)
    if current_path =~ /projects/ && target_path =~ /#work$/
      selected = true
    elsif !options[:shallow]
      selected ||= current_path.start_with?(target_path.split(/[#\?]/).first)
    end
    %{<a href="#{href('/' + target_path)}" class="#{'selected' if selected}">#{label}</a>}
  end

  def load_yaml(filename)
    YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../config/' + filename))
  end

  def projects
    @projects ||= load_yaml('projects.yml')
  end

  # if a target project is given
  # remove target project and order the array starting from next project after target project
  # otherwise return all the projects
  def arrange_projects(target_project)
    if target_project
      index = projects.index {|p| p['name'].downcase.to_sym == target_project}
      head, *tail = projects.rotate(index)
      tail
    else
      projects
    end
  end
end