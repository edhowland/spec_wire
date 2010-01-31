require 'rubygems'
require 'json'
require 'rest_client'
require 'cgi'
require 'spec_wire'

class ClassProxy
  attr_reader :our_id, :session_cookies, :meta

  def self.server_url
    SpecWire::Initializer.config.server_url
  end
  def server_url
    SpecWire::Initializer.config.server_url
  end
  def put_needs_method_arg?
    SpecWire::Initializer.config.put_needs_method_arg
  end

  def initialize(*args)
    begin
      resp = RestClient.post("#{server_url}/class/#{self.class.name}", :args => JSON.generate(args))
      # puts "resp " + resp
      @meta = JSON.parse(resp)
      @our_id = @meta['id']
      @session_cookies = resp.cookies
    rescue RestClient::Exception => e
      error = JSON.parse(e.http_body)
      raise StandardError.new(error["error"])
    # rescue Exception => e
    #   "exception occured " + e.message
    end
  end
  
  def self.method_missing(method_name, *args)
    begin
      JSON.parse(RestClient.get("#{server_url}/class/#{self.name}/msg/" + method_name.to_s + '/args/' + CGI.escape(JSON.generate(args))))[0]
    rescue RestClient::Exception => e
      error = JSON.parse(e.http_body)
      raise StandardError.new(error["error"])
    # rescue Exception => e
    #   "exception occured " + e.message
    end
  end
  
  def method_missing(method_name, *args)
    additional_args = {}
    begin
      additional_args = {:method => 'PUT'} if put_needs_method_arg?
      JSON.parse(RestClient.put("#{server_url}/object/" + @our_id.to_s + '/msg/' + method_name.to_s, 
        {:args => JSON.generate(args)}.merge(additional_args), {:cookies => @session_cookies}))[0]
    rescue RestClient::Exception => e
      error = JSON.parse(e.http_body)
      raise StandardError.new(error["error"])
    # rescue Exception => e
    #   "exception occured " + e.message
    end
  end
  
end