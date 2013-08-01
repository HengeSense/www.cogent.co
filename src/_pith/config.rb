require 'time'
require 'twitter'
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