require 'socket'  					#get sockets from stdlib 

server = TCPServer.open(2000)		#socket to listen on port 2000
loop { 								#servers run forever 
	client = server.accept 			#wait for a client to connect 
	client.puts(Time.now.ctime) 	#send the time to the client
	client.puts "Closing the connection. Bye!"
	#while line = client.gets			#read lines from the socket 
	#	puts line.chop					#and print with platform line terminator 
	#end 
	request = []
	request = client.gets.split(" ")
	request_method = request[0]
	request_resource = ".#{request[1]}"
	if request_method == "GET" && File.exists?(request_resource)
		client.puts "HTTP/1.0 200 OK"
		client.puts "Date: #{File.mtime(request_resource)}"
		client.puts "Content-Type: text/html"
		client.puts "Content-Length: #{request_resource.size}\r\n\r\n"
		body = File.read request_resource
		client.puts body
	else 
		client.puts "HTTP/1.0 404 Not Found\r\n\r\n"
	end
	puts request
	puts Dir.pwd

	client.close					#Disconnect from the client
}	

