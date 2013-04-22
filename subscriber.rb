require 'rubygems'
require 'stomp'
 
 
 
client_id = "mystomp"
subscription_name = "mystomp"
topic_name = "stompcat"
 
 
 
stomp_params = {
:hosts => [
{ :host => "localhost", :port => 61613},
],
:connect_headers => {'client-id' => client_id},
 
}
 
 
client = Stomp::Client.new stomp_params
 
client.subscribe "/topic/#{topic_name}", { "ack" => "client", "activemq.subscriptionName" => subscription_name} do |msg|
 
 
puts "--------------body----------------"
p msg.body
puts "--------------headers----------------"
p msg.headers
puts "-----end-----"
 
client.acknowledge msg
end
 
client.join