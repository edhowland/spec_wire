require 'sinatra'

enable :sessions

get '/' do
  session['bb'] = 'something'
  "session set"
end

get '/bb' do
  session['bb']
end