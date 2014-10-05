# -*- coding: utf-8 -*-
require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "cinch-title"
    gem.summary = %Q{Plugin for Cinch to output HTML-titles}
    gem.description = %Q{Plugin for the irc-framework Cinch to output HTML-titles}
    gem.email = "victor.bergoo@gmail.com"
    gem.homepage = "http://github.com/netfeed/cinch-title"
    gem.authors = ["Victor Bergoo"]
    gem.license = "MIT"
    gem.files = ["lib/**/*.rb", "README.rdoc", "LICENSE"]
    gem.add_dependency "cinch"
    gem.add_dependency "nokogiri"
    gem.add_dependency "curb"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
