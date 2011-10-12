module YamlConfig
  def project_yaml
    projects_yaml.find {|p| p['name'] == @project_name }
  end
  
  def load_yaml(filename)
    YAML.load(File.read(File.expand_path(File.dirname(__FILE__) + '/../config/' + filename)))
  end
  
  def projects_yaml
    @project_yaml ||= load_yaml('projects.yml')
  end
  
  def people_yaml
    @people_yaml ||= load_yaml('people.yml')
    p @people_yaml
    @people_yaml
  end
  
  def projects_html(count=nil, include_images=true, excluded=nil)
    yaml = projects_yaml.select {|p| p['name'] != excluded }
    yaml = yaml.first(count) if count
    yaml.map do |project|
      photo = project_photos(project).first if include_images
      project_html(project, photo)
    end.join
  end
  
end