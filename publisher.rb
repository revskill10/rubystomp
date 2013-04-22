
require 'rubygems'
require 'stomp'

continue = true

trap("INT") {
  puts "CTRL+C"
  puts "shutting down ..."
  @conn.disconnect
  sleep 1
  STDIN.close
}

  
@port = 61613
@host = "localhost"
#@user = ENV["STOMP_USER"];
#@password = ENV["STOMP_PASSWORD"]
    
@host = ENV["STOMP_HOST"] if ENV["STOMP_HOST"] != NIL
@port = ENV["STOMP_PORT"] if ENV["STOMP_PORT"] != NIL
    
@destination = "/topic/stompcat"
@destination = $*[0] if $*[0] != NIL
    
$stderr.print "Connecting to stomp://#{@host}:#{@port} as #{@user}\n"
@conn = Stomp::Connection.open '', '', @host, @port, true, { 'client-id' => "mystomp" }
$stderr.print "Sending input to #{@destination}\n"



begin
  STDIN.each_line { |line| 
    @conn.publish @destination, line, {:persistent =>'true'}
  }
rescue IOError
end