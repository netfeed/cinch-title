#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Copyright (c) 2010 Victor Bergöö
# This program is made available under the terms of the MIT License.

require 'cinch'
require 'nokogiri'
require 'curb'
require 'uri'
require 'cgi'

module Cinch
  module Plugins
    module Netfeed
      class HTMLTitle
        include Cinch::Plugin
        
        match /(.*http.*)/, :use_prefix => false
        
        def execute m, message
          suffix =  m.user.nick[-1] == 's' ? "'" : "'s"

          ignore = ["jpg$", "jpeg$", "gif$", "png$", "bmp$"]
          ignore += config["ignore"] if config.key? "ignore"

          URI.extract(message, ["http", "https"]) do |uri|
            begin
              ignore.each do |re| 
                raise ArgumentError.new "dang it" if uri =~ /#{re}/
              end
              
              m.reply "#{m.user.nick}#{suffix} URL: #{parse(uri)}"
            rescue ArgumentError => e
              next
            rescue URI::InvalidURIError => e
              m.reply "invalid url: #{uri}"
            end
          end
        end

        def parse uri
          content = Curl::Easy.perform(uri).body_str
          html = Nokogiri::HTML(content)
          title = html.at("title")

          return "No title" if title.nil?
          CGI.unescape_html title.text.gsub(/\s+/, ' ')
        end
      end
    end
  end
end