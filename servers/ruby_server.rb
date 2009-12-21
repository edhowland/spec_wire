#!/usr/bin/env ruby
# reference spec_wire server in Ruby
require 'sinatra'
require 'logger'
require 'haml'
require 'json'
require 'cgi'
require 'pp'

def logit(msg)
  File.open("spec_wire.log", "a+") do |f|
    f.puts(msg)
  end
end

get '/' do
  logit('Get / response ok sent')
  "response ok"
end

# test classes
class Foo
  attr_accessor :val1, :val2
  def initialize(v1, v2)
    @val1 = v1
    @val2 = v2
  end
  def baz?
    false
  end
  def to_json(*args)
    {
      :json_class => self.class.name,
      :data => [val1, val2],
      :id => object_id
    }.to_json(*args)
  end
end
class Bar < Foo
   attr_accessor :foo, :baz
   def self.find(count)
     count
   end
   def self.locate
     'y'
   end
end

#  our object store
@@object_store = {}

# raw get of an object - useful for debugging? Or other servers
get '/object/:id' do |id|
  logit 'get of ' + id
  object = @@object_store[id.to_i]
  unless object.nil?
    status[200]
    object.to_json
  else
    status[404]
    logit 'object_store ' + @@object_store.inspect
    "Object not found"
  end
end

# execute a class level method
# TODO implement
get '/class/:name/msg/:message/args/:args' do |name, message, args|
  if name =~ /Foo|Bar/
    klass = Kernel.const_get(name)
    # TODO how to handle nil returned from method
    begin
      puts params.inspect
      unless args.nil? or args == "[]"
        args = JSON.parse(CGI.unescape(args))
        result = klass.send(message, args)
      else
        result = klass.send(message)
      end
      unless result.nil?
        status[200]
        JSON.generate([result])
      else
        status[422]
        "Method error"
      end
    rescue => e
      status[500]
      e.message
    end
  else
    status[404] # pending
    "Pending - class not found"
  end
end

# creates a new class and returns it via json {:id => object_id, :attr => 'value_or_nil'}
post '/class/:name' do |name|
  args = JSON.parse(params[:args])
  if name =~ /Foo|Bar/
    object = Kernel.const_get(name).new(*args)
    status[201]
    @@object_store[object.object_id] = object
    object.to_json
  else
    status[404]
    "Class not found"
  end
end

# modify an object's state
put '/object/:id/msg/:message' do |id, message|
  object = @@object_store[id.to_i]
  unless object.nil?
    status[200]
    unless params[:args] == "[]"
      args = JSON.parse(params[:args])
      # puts "params[:args]" + params[:args].inspect
      JSON.generate([object.send(message, args)])
    else
      JSON.generate([object.send(message)])
    end
  else
    status[404]
    "Object not found"
  end
end
