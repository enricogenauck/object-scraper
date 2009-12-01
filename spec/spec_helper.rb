$: << File.join(File.dirname(__FILE__), '..', 'lib')
$: << File.join(File.dirname(__FILE__))
 
require 'rubygems'
 
require 'activerecord'
 
require 'spec'
require 'spec/autorun'
require 'rr'
 
require 'object-scraper'
 
Spec::Runner.configure do |config|
  config.mock_with RR::Adapters::Rspec
end