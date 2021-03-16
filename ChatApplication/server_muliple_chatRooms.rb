require 'socket'


class Server
  def initialize(port, ip)
    @server=TCPServer.open(ip, port)
    @connections=Hash.new
    @clients=Hash.new
    @connections[:clients]=@clients
    @chatrooms={"alpha":{}, "bravo":{}}
    run
  end

  def run
    loop{
      t1=Thread.new(@server.accept) do |client|
        
=begin
        @connections[:clients].each do |clname, cl|
          if client_name==clname || client==cl
            client.puts "User already exisits.."
            Thread.kill self
          end
        end
=end
        client_name=nil
        chatrm=nil

        flg=true
        while flg
          client_name=client.gets.chomp.to_sym
          @chatrooms.keys.each{|room| client.puts room}
          client.puts "Enter chat room name: "
          chatrm = client.gets.chomp.to_sym
          @chatrooms.keys.each{|k| puts k}
          if @chatrooms.has_key?(chatrm)
            @chatrooms[chatrm].each do |clname, cl|
              if clname==client_name
                client.puts "User already exisits...Try again with different username"
                next
              end
            end
            flg = false
            break
          end
          client.puts "Invalid room. Try again..."
          client.puts "Enter username: "
        end


        @chatrooms[chatrm][client_name]=client
          
        puts "#{chatrm} ==> #{client_name} ==> #{client}"
        client.puts "Welcome to \"#{chatrm}\" chat room...."
        client.puts "\t--Type \"exit\" for leaving chat room"
        client.puts "\t--Type \"showall\" for displaying active members in chat room"

        @chatrooms[chatrm].each do |clname, cl|
          if clname != client_name
            cl.puts "***************#{client_name} joined this chat room***************"
          end
        end

        listen_message(client_name, client, chatrm)
      end
    }.join
  end

  def listen_message(username, client, chatrm)
    chatroom=chatrm
    loop{
      msg = client.gets.chomp

      if msg=="exit"
        @chatrooms[chatroom].delete(username)
        @chatrooms[chatroom].each do |clname, cl|
            cl.puts "---------------- #{username} LEFT the chat room...!!! ----------------"
        end
        Thread.exit
      end


      if msg=="showall"
        client.puts "Members in chat room: "
        @chatrooms[chatroom].each do |clname, cl|
          client.puts "#{clname}"
        end

      else
        @chatrooms[chatroom].each do |clname, cl|
          if clname != username
            cl.puts "#{username}: #{msg}"
          end
        end
      end
    }
  end

end

Server.new(2000, "localhost")
