# -*- encoding: utf-8 -*-
# stub: cinch-title 0.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "cinch-title"
  s.version = File.new("VERSION", 'r').read.chomp

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Victor Bergoo"]
  s.date = Time.now.strftime("%Y-%m-%d")
  s.description = "Plugin for the irc-framework Cinch to output HTML-titles"
  s.email = "victor.bergoo@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "lib/cinch/plugins/title.rb"
  ]
  s.homepage = "http://github.com/netfeed/cinch-title"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Plugin for Cinch to output HTML-titles"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cinch>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<curb>, [">= 0"])
    else
      s.add_dependency(%q<cinch>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<curb>, [">= 0"])
    end
  else
    s.add_dependency(%q<cinch>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<curb>, [">= 0"])
  end
end

