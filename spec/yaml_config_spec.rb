require File.expand_path(File.dirname(__FILE__) + '/../lib/yaml_config.rb')

class TestYamlConfig
  include YamlConfig
end

describe YamlConfig do
  let(:subject) { TestYamlConfig.new }
end