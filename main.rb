require 'uri'
require 'net/http'
require 'openssl'
require "json"
require 'thread'
require 'pry'

require_relative "globals"
require_relative "api"
require_relative "file"
require_relative "threads"




def list_commands()
    puts ""
    puts "coin TICKER, c TICKER      : sets coin ticker and prints it"
    puts "n                          : print coin price"
    puts "t                          : loops price every second"
    puts "spread NUMBER              : sounds on price movement either direction"
    puts "stop THREAD-TYPE           : stops specified thread"
    puts "threads                    : shows threads alive"
    puts "add coin                   : appends coin to list"
    puts "delete coin                : delete coin from list"
    puts "list coin                  : reads coin list"
    puts "exit                       : will exit any command or the program"
    puts ""
end



def command(arg)
    
    array = arg.split
    if array.length > 2
        puts "bad command"
    end
    
    case array.first
    when "coin" 
        coin(array)
    when "c"
        coin(array)
    when "n"
        puts api(nil)
    when "t"
        time(array[1].to_i)
        $seconds = array[1].to_i
    when "spread"
        spread_set(array[1].to_i)
    when "threads"
        threads
    when "stop"
        stop(array[1])
    when "add"
        append_list
    when "delete"
       delete_from_list
    when "list"
       print_list
    when "total"
        puts total
    when "help"
        list_commands
    when "exit"
        exit(true)
    else
        puts "command not found"
    end

end

if !File.exists?("coin.json")
    File.open("coin.json", "w+") {|f| f.write("{}") }
end

while true
    command(gets.chomp)
end

