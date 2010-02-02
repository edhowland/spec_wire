#!/usr/bin/env ruby
# parse_id.rb - parses input file and writes out object id
require 'json'
# class Bar; end

str=""
File.open(ARGV[0]) do |f|
  str=f.read
end

h=JSON.parse str.sub(/json_class/, "class")

File.open(ARGV[1], "w") do |f|
  f.puts(h["id"])
end

