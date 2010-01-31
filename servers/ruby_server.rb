#!/usr/bin/env ruby
# reference spec_wire server in Ruby
require 'rubygems'
require 'sinatra'
require 'json'
require 'cgi'
require 'pp'

class ArgumentsMissing < StandardError; end

def logit(msg, *args)
  File.open("spec_wire.log", "a+") do |f|
    f.write(msg)
    begin
      f.write('|')
      f.write(args.map {|arg| arg.inspect}.join(','))
      f.write('|')
    end unless args.length == 0
    f.puts
  end
end

def instance_variable_to_sym(var)
  var.to_s[/^@(.*)/,1].to_sym
end 

def instance_vars_to_hash(object)
  result = {}
  object.instance_variables.each do |var|
    result[instance_variable_to_sym(var)] = object.send instance_variable_to_sym(var)
  end
  result
end

def object_to_json(object, *args)
    {
      :json_class => object.class.name,
      :data => [instance_vars_to_hash(object)],
      :id => object.object_id
    }.to_json(*args)
end

require File.join(File.expand_path(File.dirname(__FILE__)), 'support', 'env')
enable :sessions

get '/' do
  logit('Get / response ok sent')
  "response ok"
end

#  our object store
@@object_store = {}

# raw get of an object - useful for debugging? Or other servers
get '/object/:id' do |id|
  logit 'get of ' + id
  object = @@object_store[id.to_i]
  unless object.nil?
    status[200]
    object_to_json(object)
  else
    logit 'object_store ' + @@object_store.inspect
    halt 404, JSON.generate({:error => "object not found"})
  end
end

# execute a class level method
get '/class/:name/msg/:message/args/:args' do |name, message, args|
  begin
    load_class_file name # our autoloader
    # TODO how to handle nil returned from method?
    klass = Kernel.const_get(name)
    unless args.nil? or args == "[]"
      args = JSON.parse(CGI.unescape(args))
      result = klass.send(message, args)
    else
      result = klass.send(message)
    end
    unless result.nil?
      JSON.generate([result])
    else
      halt 422, JSON.generate({:error => "Method :#{message} error"})
    end
  rescue LoadError => e
    logit "class not found #{name} in #{name.to_underscores}.rb"
    halt 404, JSON.generate({:error => "Class #{name} not found"})
  rescue Exception => e
    halt 422, JSON.generate({:error => e.message})
  end
end

# creates a new class and returns it via json {:id => object_id, :attr => 'value_or_nil'}
post '/class/:name' do |name|
  begin
    load_class_file name # our form of autoloading de-CamelCased file names
    raise ArgumentsMissing.new("args parameter missing") if params[:args].nil?
    args = JSON.parse(params[:args])
    object = Kernel.const_get(name).new(*args)
    @@object_store[object.object_id] = object
    session[object.object_id] = object
    logit "POST class:" + object.class.name + " created"
    object_to_json object
  rescue LoadError => e
    logit "class not found #{name} in #{name.to_underscores}.rb"
    halt 404, JSON.generate({:exception => 'LoadError', :error => "Class #{name} not found"})
  rescue Exception => e
    halt 422, JSON.generate({:exeption => e.class.name, :error => e.message})
  end
end

# modify an object's state
put '/object/:id/msg/:message' do |id, message|
  logit 'PUT session:' + session.inspect
  begin 
    object = @@object_store[id.to_i]
    raise Sinatra::NotFound.new("Object<#{id}> not found") if object.nil?
    unless params[:args] == "[]"
      args = JSON.parse(params[:args])
      JSON.generate([object.send(message, *args)])
    else
      JSON.generate([object.send(message)])
    end
  rescue Sinatra::NotFound => e
    halt 404, JSON.generate({:error => e.message})
  rescue Exception => e
    halt 422, JSON.generate({:error => e.message})
  end
end
