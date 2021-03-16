require 'socket'
class Client
    def initialize(server)
        @server=server
        @request=nil
        @response=nil
        listen
        send
        @request.join
        @response.join
    end

    def listen
        @response=Thread.new do
            loop{
                msg = @server.gets.chomp
                puts msg
            }
        end
    end

    def send
        print "Enter username: "
        
        @request=Thread.new do
            loop{
                msg=$stdin.gets.chomp
                if msg=="exit"
                    @server.puts msg
                    Thread.list.each{|thrd| thrd.exit}
                    puts Thread.list
                elsif msg=="showall"
                    @server.puts msg
                else
                    @server.puts msg
                end
            }
        end
    end






end

server=TCPSocket.open("localhost", 2000)
Client.new(server)