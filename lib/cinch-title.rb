#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Copyright (c) 2010 Victor Bergöö
# This program is made available under the terms of the MIT License.

require 'cinch'
require 'nokogiri'
require 'httpclient'
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

          ignore = []
          ignore = config["ignore"] if config.key? "ignore"

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
          client = HTTPClient.new
          content = client.get(uri).content
          content.force_encoding "UTF-8"
          
          html = Nokogiri::HTML(content, encoding="UTF-8")
          CGI.unescape_html html.at("title").text.gsub(/\s+/, ' ')
        end
      end
    end
  end
end