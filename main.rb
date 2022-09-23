require 'uri'
require 'net/http'
require 'openssl'
require "json"
require 'thread'


def api()
    url = URI("https://api.coinbase.com/v2/prices/#{$coin}-USD/buy")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    response = http.request(request)
    parsed = JSON.parse(response.body) # returns a hash
    #add error checking
    begin
        price = parsed["data"]["amount"]
    rescue
        puts "api error"
        return -1
    end
    if $spread_on == true
        spread_check(price.to_f)
    end
    return price.to_f
end

def spread_check(price)

    if ($price - price).abs >= $spread_number
            
        if $spread&.alive?
                return
        else
            $spread = Thread.new { 
                while true
                    `say "spread"`
                end
            }
        end        
    end

end

def spread_set(number)
    $price = api
    $spread_number = number
    $spread_on = true
end

$time = nil
$spread = nil
$coin = "eth"
$price = 0
$spread_number = 0
$spread_on = false

def threads() 
    puts "#{(Thread.list.length) - 1} loops running"
    time = $time&.alive? ? true : false 
    puts "Is time thread alive? #{time}" 
    spread = $spread&.alive? ? true : false 
    puts "Is spread thread alive? #{spread}"
    if $spread_on
        puts "Spread is set to #{$spread_number}"
    end
end

def stop(arg)
    if arg == "time" and $time&.alive?
        Thread.kill($time)
    elsif arg == "spread" and $spread&.alive?
        $spread_on = false
        Thread.kill($spread)
    else
    puts "thread not found"
    end
end

def list_commands()
    puts ""
    puts "coin TICKER, c TICKER      : sets coin ticker and prints it"
    puts "n                          : print coin price"
    puts "t                          : loops price every second"
    puts "spread NUMBER              : sounds on price movement either direction"
    puts "stop THREAD-TYPE           : stops specified thread"
    puts "threads                    : shows threads alive"
    puts "exit                       : will exit any command or the program"
    puts ""
end

def time(seconds)
    
    if !$time.nil? and $time.alive?
            stop("time")
    end

    $time = Thread.new { 
        while true
            puts api
            sleep(seconds)
        end
    }
end

def coin(array)
    if array[1].nil?
        puts "Current coin is: #{$coin}"
    else
        $coin = array[1]
        puts api()
    end
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
        puts api
    when "t"
        time(array[1].to_i)
    when "spread"
        spread_set(array[1].to_i)
    when "threads"
        threads
    when "stop"
        stop(array[1])
    when "help"
        list_commands
    when "exit"
        exit(true)
    else
        puts "command not found"
    end

end

while true
    command(gets.chomp)
end

