#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Copyright (c) 2010 Victor Bergöö
# This program is made available under the terms of the MIT License.

require 'cinch'
require 'nokogiri'
require 'httpclient'
require 'uri'

module Cinch
  module Plugins
    module Netfeed
      class HTMLTitle
        include Cinch::Plugin
        
        match /(.*http.*)/, :use_prefix => false
        
        def execute m, message
          suffix =  m.user.nick[-1] == 's' ? "'" : "'s"
          ignore = config["ignore"] || []

          URI.extract(message) do |uri|
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
          resp = client.get(uri)
          
          html = Nokogiri::HTML(resp.content)
          html.xpath("//head/title").first.content
        end
      end
    end
  end
end