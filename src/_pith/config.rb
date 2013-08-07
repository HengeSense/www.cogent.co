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
    path.to_s.sub(/index\.html$/, "").sub(/\.html$/, "")
  end
  
  def nav_link(target_ref, label, options = {})
    target_path = abbreviate_path(target_ref)
    current_path = abbreviate_path(page.output_path)
    selected = (target_path == current_path)
    unless options[:shallow]
      selected ||= current_path.start_with?(target_path)
    end
    %{<a href="#{target_path}" class="#{'selected' if selected}">#{label}</a>}
  end
end