#!/usr/bin/env ruby
##
# This program is to ping the IP given on HTTP, ICMP, and RDP ports respectively
# You will need Ruby and the net-ping gem installed.
# Ruby can be found at ruby-lang.org and the net-ping gem can be installed via the 'gem' command.
require "net/ping"
require "ffi"

##
# The user will input the IP to be checked.


##
# Going to break the IP into an array to check to see if it's a valid IP
def ip_tester(ip)
  validate = ip.split(".")
  raise ArgumentError "Not a valid IP" unless validate[0].to_i > 0 && validate[1].to_i > 0 && validate[2].to_i > 0 && validate[3].to_i > 0
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
  if test.ping
    puts "IP is active."
  else
    puts "IP is not active"
  end

##
# Then we send out an ICMP (Classic Ping)
# This uses the OS' built in 'ping' command and puts it in a text file for perusal.

  puts "Testing ICMP"
  case RbConfig::CONFIG['host_os'].downcase
  when /mingw|mswin/
  `ping #{validate[0]}.#{validate[1]}.#{validate[2]}.#{validate[3]} > pingtest.#{validate[0]}.#{validate[1]}.#{validate[2]}.#{validate[3]}.txt`
  when /linux|darwin|bsd|solaris|sunos/
    `ping -c 4 #{validate[0]}.#{validate[1]}.#{validate[2]}.#{validate[3]} > pingtest.#{validate[0]}.#{validate[1]}.#{validate[2]}.#{validate[3]}.txt`
    puts "Please see the file 'pingtest.#{validate[0]}.#{validate[1]}.#{validate[2]}.#{validate[3]}.txt' for results."
  else
    puts "Use Standard Ruby"
  end
end
