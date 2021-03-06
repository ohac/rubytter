#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'rubytter'

if ARGV.size < 2
  puts "Usage: ruby #{File.basename(__FILE__)} user_id password"
  exit
end

client = Rubytter.new(ARGV[0], ARGV[1])
client.replies.each do |status|
  puts "#{status.user.screen_name}: #{status.text}"
end
