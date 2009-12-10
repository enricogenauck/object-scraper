class Scraper

  # Raised when a scraper is defined with the same name as a previously-defined scraper.
  class DuplicateDefinitionError < RuntimeError
  end

  class << self
    attr_accessor :scrapers
    attr_accessor :scrape_source_with
    attr_accessor :definition_file_paths
  end

  self.scrapers = {}
  self.scrape_source_with = Proc.new { |source| Hpricot(source) }
  self.definition_file_paths = %w(scrapers)

  attr_reader :scraper_source, :scraper_node

  def self.define(name, options = {}, &block)
    instance = Scraper.new(name, options, &block)

    if self.scrapers[name] 
      raise DuplicateDefinitionError, "Scraper already defined: #{name}"
    end

    self.scrapers[name] = instance
  end

  def initialize(name, options = {}, &block) #:nodoc:
    assert_valid_options(options)
    @objects  = []
    @class    = class_for(options[:class])
    @scraper_source   = options[:source]
    @scraper_node     = options[:node]
    @block    = block
  end

  def self.get(name)
    scraper_by_name(name)
  end

  def self.parse(name)
    scraper_by_name(name).parse
  end

  def parse
    doc = open(@scraper_source) { |f| Scraper.scrape_source_with.call(f) }
    doc.search(@scraper_node).each do |n|
      @current_node   = n
      @current_object = @class.new
      @objects << @current_object
      @block.call(self)
    end
    @objects
  end

  def self.scraper_by_name(name)
    scrapers[name.to_sym] or raise ArgumentError, "No such scraper: #{name.to_s}"
  end

  def method_missing(symbol, *args, &block)
    if block_given?
      @current_object.send("#{symbol}=", yield(@current_node))
    else
      @current_object.send("#{symbol}=", args.first)
    end
  end
  
  def self.find_definitions
    definition_file_paths.each do |path|
      require("#{path}.rb") if File.exists?("#{path}.rb")

      if File.directory? path
        Dir[File.join(path, '*.rb')].each do |file|
          require file
        end
      end
    end
  end

  private

  def class_for(class_or_to_s)
   if class_or_to_s.respond_to?(:to_sym)
     Object.const_get(variable_name_to_class_name(class_or_to_s))
   else
     class_or_to_s
   end
  end
  
  def scraper_name_for(class_or_to_s)
    if class_or_to_s.respond_to?(:to_sym)
      class_or_to_s.to_sym
    else
      class_name_to_variable_name(class_or_to_s).to_sym
    end
  end

  def class_name_to_variable_name(name)
    name.to_s.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end

  def variable_name_to_class_name(name)
    name.to_s.
      gsub(/\/(.?)/) { "::#{$1.upcase}" }.
      gsub(/(?:^|_)(.)/) { $1.upcase }
  end

  def assert_valid_options(options)
    invalid_keys = options.keys - [:class, :source, :node] 
    unless invalid_keys == []
      raise ArgumentError, "Unknown arguments: #{invalid_keys.inspect}"
    end
    unless options[:class]
      raise ArgumentError, "Missing argument: :class"
    end
    unless options[:source]
      raise ArgumentError, "Missing argument: :source"
    end
    unless options[:node]
      raise ArgumentError, "Missing argument: :node"
    end
  end
end