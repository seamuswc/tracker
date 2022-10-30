
require 'uri'
require 'net/http'
require 'openssl'
require "json"
require 'thread'
require 'byebug'

require_relative "globals"
require_relative "api"
require_relative "file"
require_relative "threads"
require_relative "calc_interest"

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

def check_command_length(array, *x)
    if x.include? array.length
        return true
    end
    puts "command not found"
    return false
end

def command(arg)
    
    array = arg.split
    
    
    case array.first
    when "coin" 
        coin(array) if check_command_length(array, 1, 2)        
    when "c"
        coin(array) if check_command_length(array, 1, 2) 
    when "n"
        puts api(nil) if check_command_length(array, 1) 
    when "t"
        time(array[1]) if check_command_length(array, 1, 2) 
    when "spread"
        return if !check_command_length(array, 1,2,3)
        if array[1] = "total"
            spread_total(array[2].to_f)
        else
            spread_set(array[1].to_f)
        end
    when "threads"
        threads if check_command_length(array, 1)
    when "stop"
        stop(array[1]) if check_command_length(array, 1, 2)
    when "add"
        append_list if check_command_length(array, 1)
    when "delete"
       delete_from_list if check_command_length(array, 1)
    when "list"
       print_list if check_command_length(array, 1)
    when "total"
        puts total if check_command_length(array, 1)
        #add a loop option, loops total every x seconds. only the sum
    when "calc"
        calc(array[1]) if check_command_length(array, 1,2)
    when "help"
        list_commands if check_command_length(array, 1)
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

