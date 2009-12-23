require 'rest_client'
require 'json'
require 'pp'

# puts RestClient.get("http://localhost:4567/object/" + ARGV[0])
# resp = RestClient.post("http://localhost:4567/class/Bar", :args => JSON.generate([1,2]))
resp = RestClient.post("http://localhost/~edh/limonade/server.php/class/Bar", :args => JSON.generate([1,2]))
pp resp.headers #[:set_cookie]