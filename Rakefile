require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('object-scraper', '0.0.1') do |p|
  p.description     = "Receipt like object extraction from HTML sources"
  p.url             = "http://github.com/eifion/uniquify"
  p.author          = "Enrico Genauck"
  p.email           = "kontakt@enricogenauck.de"
  p.ignore_pattern  = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }