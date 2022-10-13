

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
    $price = api(nil)
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
end

def stop(arg)
    arg ||= "both"
    if (arg == "time" or arg == "both") and $time&.alive?
        Thread.kill($time)
    elsif (arg == "spread" || arg == "both") and $spread&.alive?
        $spread_on = false
        Thread.kill($spread)
    else
        puts "no threads found"
    end
end


def time(seconds)
    
    if !$time.nil? and $time.alive?
            stop("time")
    end

    $time = Thread.new { 
        while true
            puts api(nil)
            sleep(seconds)
        end
    }
end