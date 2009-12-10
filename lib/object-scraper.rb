require 'object-scraper/scraper'
require 'open-uri'
require 'hpricot'

# Shortcut for Scraper.extract
#
# Example:
#   Scraper(:my_space)
def Scraper(name)
  Scraper.get(name)
end

if defined? Rails.configuration
  Rails.configuration.after_initialize do
    Scraper.definition_file_paths = [File.join(RAILS_ROOT, 'scrapers')]
    Scraper.find_definitions
  end
else
  Scraper.find_definitions
end