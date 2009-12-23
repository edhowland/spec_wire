# app.rb

configure do
  LOGGER = Logger.new("sinatra.log") 
end
 
helpers do
  def logger
    LOGGER
  end
end