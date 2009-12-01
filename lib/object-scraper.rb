require 'object-scraper/scraper'
require 'open-uri'
require 'hpricot'

# Shortcut for Scraper.extract
#
# Example:
#   Scraper(:my_space)
def Scraper(name)
  Scraper.extract(name)
end