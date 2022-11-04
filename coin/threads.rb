class Coin_Threads

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
        Api.new
        $price = Api.new.api(nil)
        $spread_number = number
        $spread_on = true
    end


    def threads() 
        puts "#{(Thread.list.length) - 1} loops running"
        time = $time&.alive? ? true : false 
        puts "Is time thread alive? #{time}" 
        if time == true
            puts "Time is looping at #{$seconds} seconds"
        end
        spread = $spread&.alive? ? true : false 
        puts "Is spread thread alive? #{spread}"
        if $spread_on
            puts "Spread is set to #{$spread_number}"
        end
        spread = $spread_total&.alive? ? true : false 
        puts "Is spread total thread alive? #{spread}"
    end

    def stop(arg)
        arg ||= "both"
        if (arg == "time" or arg == "both") and $time&.alive?
            Thread.kill($time)
        elsif (arg == "spread" || arg == "both") and $spread&.alive?
            $spread_on = false
            Thread.kill($spread)
        elsif (arg == "total" || arg == "both") and $spread_total&.alive?
            Thread.kill($spread_total)
        else
            puts "no threads found"
        end
    end


    def time(seconds = nil)
        
        if seconds.nil?
            puts "Time is #{$seconds}"
            return
        end
        seconds = seconds.to_i
        if seconds == 0
            puts "Time must be an interger and cannot be 0"
            return
        end

        if !$time.nil? and $time.alive?
                stop("time")
        end

        $seconds = seconds
        $time = Thread.new { 
            while true
                puts Api.new.api(nil)
                sleep(seconds)
            end
        }
    end

    def spread_total(amount)
        #byebug
        #int check on amount
        obj = File_Coin.new
        first = obj.total(1)
        $spread_total = Thread.new {
            while true
                sleep(10) 
                t = obj.total(1)
                next if t.nil? #if api breaks it just skips this loops and trys next time
                if (t - first).abs >= amount
                    puts "was #{first}, is now #{t}"
                    while true    
                        `say "spread total"`
                    end
                end
            end
        }


    end

end