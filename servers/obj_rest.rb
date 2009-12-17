#!/usr/bin/env ruby
# obj_rest.rb - "An object at rest tends to..." REST client for objects

require 'const'

# Instantiate Bar from server's version via HTTP post action
f=Bar.new(1,2)
puts f.inspect

