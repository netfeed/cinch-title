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
    class Title
      include Cinch::Plugin
      
      match /(.*http.*)/, :use_prefix => false
      
      def execute m, message
        suffix =  m.user.nick[-1] == 's' ? "'" : "'s"

        URI.extract(message, ["http", "https"]) do |uri|
          begin
            next if ignore uri
            
            m.reply "#{m.user.nick}#{suffix} URL: #{parse(uri)}"
          rescue URI::InvalidURIError => e
            m.reply "invalid url: #{uri}"
          end
        end
      end

      private

      def parse uri
        content = Curl::Easy.perform(uri).body_str
        html = Nokogiri::HTML(content)
        title = html.xpath('//title').first
        
        return "No title" if title.nil?
        CGI.unescape_html title.text.gsub(/\s+/, ' ')
      end
      
      def ignore uri
        ignore = ["jpg$", "JPG$", "jpeg$", "gif$", "png$", "bmp$", "pdf$"]
        ignore += config["ignore"] if config.key? "ignore"
        
        ignore.each do |re|
          return true if uri =~ /#{re}/
        end
        
        false
      end
    end
  end
end