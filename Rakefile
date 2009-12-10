require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('object-scraper', '0.0.2') do |p|
  p.summary         = "Receipt like object extraction from HTML sources"
  p.description     = "Object scraper is a thin wrapper for hpricot to enable receipt-like extraction of ruby objects from various web sites."
  p.url             = "http://github.com/enricogenauck/object-scraper"
  p.author          = "Enrico Genauck"
  p.email           = "kontakt@enricogenauck.de"
  p.ignore_pattern  = ["tmp/*", "script/*"]
  p.development_dependencies = []
  p.runtime_dependencies = ["hpricot >=0.8.2"]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }