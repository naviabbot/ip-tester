##
# This program is to ping the IP given on HTTP, ICMP, and RDP ports respectively
# You will need Ruby and the net-ping gem installed.
# Ruby can be found at ruby-lang.org and the net-ping gem can be installed via the 'gem' command.

require "net/ping"
require "ffi"

##
# The user will input the IP to be checked.

puts "Josh Cain's Ruby IP Tester."
puts "For Internal Distribution."
puts "Tests a dedicated IP using the power of PING."
puts "IP to Test"
ip = gets.chomp

##
# Going to break the IP into an array to check to see if it's a valid IP

validate = ip.split(".")
raise ArgumentError "Not a valid IP" unless validate[0].to_i > 0 && validate[1].to_i > 0 && validate[2].to_i > 0 && validate[3].to_1 > 0
raise ArgumentError "Not in our Range" unless validate[0].to_i == 70 || 208 || 212 || 199
raise ArgumentError "Not in our Range" unless validate[1].to_i == 34 || 88 || 84 || 241
raise ArgumentError "We don't do ServerSilo dedicated IPs anymore" if validate[0] == 198 && validate[1] == 55
validate.each do |octet|
if Integer(octet).between?(0,255)
puts "Valid octet found"
else
puts "You fail. That isn't a valid IP. TRY AGAIN!"
exit 1
end
end


##
# The first thing we do is to ping the HTTP

test = Net::Ping::HTTP.new("http://#{validate[0]}.#{validate[1]}.#{validate[2]}.#{validate[3]}")
puts "Testing HTTP"
puts test.ping?

##
# Then we send out an ICMP (Classic Ping)
# This uses the OS' built in 'ping' command and puts it in a text file for perusal.

puts "Testing ICMP"
case RbConfig::CONFIG['host_os'].downcase
when /mingw|mswin/
`ping #{validate[0]}.#{validate[1]}.#{validate[2]}.#{validate[3]} > pingtest.#{validate[0]}.#{validate[1]}.#{validate[2]}.#{validate[3]}.txt`
when /linux|darwin|bsd|solaris|sunos/
`ping -c 4 #{validate[0]}.#{validate[1]}.#{validate[2]}.#{validate[3]} > pingtest.#{validate[0]}.#{validate[1]}.#{validate[2]}.#{validate[3]}.txt`
else
puts "Use Standard Ruby"
end 

##
# Now we test RDP.

puts "Testing RDP."

test2 = Net::Ping::TCP.new("#{validate[0]}.#{validate[1]}.#{validate[2]}.#{validate[3]}", port=3389)
puts test2.ping?
