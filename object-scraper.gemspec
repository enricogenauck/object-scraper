# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{object-scraper}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Enrico Genauck"]
  s.date = %q{2010-02-03}
  s.description = %q{Object scraper is a thin wrapper for hpricot to enable recipe-like extraction of ruby objects from various web sites.}
  s.email = %q{kontakt@enricogenauck.de}
  s.extra_rdoc_files = ["README.rdoc", "lib/object-scraper.rb", "lib/object-scraper/scraper.rb"]
  s.files = ["Manifest", "README.rdoc", "Rakefile", "lib/object-scraper.rb", "lib/object-scraper/scraper.rb", "object-scraper.gemspec", "spec/data/twitter.html", "spec/object-scraper/scraper_spec.rb", "spec/spec.opts", "spec/spec_helper.rb"]
  s.homepage = %q{http://github.com/enricogenauck/object-scraper}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Object-scraper", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{object-scraper}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Recipe like object extraction from HTML sources}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hpricot>, [">= 0.8.2"])
    else
      s.add_dependency(%q<hpricot>, [">= 0.8.2"])
    end
  else
    s.add_dependency(%q<hpricot>, [">= 0.8.2"])
  end
end
