
def list_commands()
    puts ""
    puts "coin TICKER, c TICKER      : sets coin ticker and prints it (coinbase api)"
    puts "n                          : print coin price"
    puts "t NUMBER                   : loops price every second"
    puts "t                          : shows loop time"
    puts "spread NUMBER              : sounds on price movement either direction"
    puts "spread total NUMBER        : sounds on price movement either direction for sum"
    puts "stop THREAD-TYPE           : stops specified thread"
    puts "stop                       : stops all thread"
    puts "threads                    : shows threads alive"
    puts "add                        : appends coin to list"
    puts "delete                     : delete coin from list"
    puts "list                       : reads coin list"
    puts "sum                        : sum of all coins list"
    puts "total     (can be argv)    : sum of each coin on list with total sum"
    puts "nft list                   : reads nft list"
    puts "nft add                    : appends nft to list (opensea api)"
    puts "nft delete                 : delete nft from list"
    puts "nft punks                  : gets the punks price (nokogiri larvalabs)"
    puts "stock TICKER               : sets stock ticker and prints it"
    puts "s                          : print stock price"
    puts "math                       : play with it, you'll figure it out. PEMDAS without parenthesis"
    puts "range                      : prints the range since time loop started"
    puts "max                        : prints the max price that has occured since time loop started"
    puts "min                        : prints the min price that has occured since time loop started"
    puts "address                    : Asks for an eth address and prints the sum. (Etherscan & nokogiri) "
    puts "exit                       : will exit any command or the program"
    puts ""
end

def check_command_length(array, *x)
    if x.include? array.length
        return true
    end
    puts "command not found, CLC"
    return false
end

def command(arg)
    
    array = arg.split

    case array.first
    when "sum"
        coin_file = File_Coin.new
        puts  coin_file.total("sum") if check_command_length(array, 1)
    when "coin" 
        api = Api.new
        api.coin(array[1], array[2]) if check_command_length(array, 1, 2, 3)        
    when "c"
        api = Api.new
        api.coin(array[1], array[2]) if check_command_length(array, 1, 2, 3) 
    when "n"
        api = Api.new
        puts api.api(nil) if check_command_length(array, 1) 
    when "t"
        coin_threads = Coin_Threads.new
        coin_threads.time(array[1]) if check_command_length(array, 1, 2) 
    when "spread"
       # byebug
        return if !check_command_length(array,1,2,3)
        if array.length == 1
            puts $spread_number 
            return
        end
        coin_threads = Coin_Threads.new
        if array[1] == "total"
            coin_threads.spread_total(array[2].to_f)
        else
            coin_threads.spread_set(array[1].to_f)
        end
    when "threads"
        coin_threads = Coin_Threads.new
        coin_threads.threads if check_command_length(array, 1)
    when "stop"
        coin_threads = Coin_Threads.new
        coin_threads.stop(array[1]) if check_command_length(array, 1, 2)
    when "add"
        coin_file = File_Coin.new
        coin_file.append_list if check_command_length(array, 1)
    when "delete"
        coin_file = File_Coin.new
        coin_file.delete_from_list if check_command_length(array, 1)
    when "list"
        coin_file = File_Coin.new
        coin_file.print_list if check_command_length(array, 1)
    when "total"
        coin_file = File_Coin.new
        puts  coin_file.total if check_command_length(array, 1)
        #add a loop option, loops total every x seconds. only the sum
    when "help"
        list_commands if check_command_length(array, 1)    
    when "nft"
        nft_commands(array)
    when "run"
        run app/ApplicationController
    when "stock"
        stock = Stock.new
        puts stock.stock(array[1], array[2]) if check_command_length(array, 1, 2, 3)  
    when "s"
        stock = Stock.new
        puts stock.api(array[1], array[2]) if check_command_length(array, 1, 2, 3)       
    when "math"
        puts Calc.calc(array)
    when "max"
        puts "MAX: " + File_Coin.new.max
    when "min"
        puts "MIN: " + File_Coin.new.min
    when "range"
        z = File_Coin.new
        max = z.max
        min = z.min
        range = max.to_f - min.to_f
        puts "MAX: " + max
        puts "MIN: " + min
        puts "range: #{range}"
    when "address"
        sum = Api.new.address
        puts sum
    when "ladia"
        puts la_dia
    when "start"
        Fork.new.spoon
    when "email"
        Fork.new.email("test")
    when "exit"
        exit(true)
    else
        puts "command not found"
    end

end

def nft_commands(array) 
    nft = Nft.new
    case array[1]
    when nil
        nft.print_list
    when "add"
        nft.append_list() if check_command_length(array, 2)
    when "delete"
        nft.delete_from_list() if check_command_length(array, 2)
    when "list" 
        nft.read_list if check_command_length(array, 2)
    when "nft"
        nft.print_list if check_command_length(array, 2)
    when "loop"
        nft.loop_list if check_command_length(array, 2)
    when "stop"
        nft.stop if check_command_length(array, 2)
    when "punks"
        puts nft.punks if check_command_length(array, 2)
    else
        puts "command not found"
    end
end

def la_dia

    "
    \tMinimalism 财富 种族主义
    \tSobriety 不手淫 不游戏 不看媒体 
    \t中国蹲 十引体上向 基本的暴力
    \t西语 中文 日语 英语  
    "
     
end