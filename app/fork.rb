
class Fork 

    def spoon
        pid = fork do
            Process.setsid #removes the child as its own process essential making a dameon
            puts Process.pid
            q = Fork.new
            q.start
        end       
        Process.detach(pid)
    end

    def calc_fall_reach
        api = Api.new
        base = api.api(nil)
        reach = (base * 0.05) + base
        fall = base - (base * 0.05)
        return([reach, fall])
    end

    def start

        id = Process.pid 
        email("program has started under PID #{id}")
    
        reach, fall = calc_fall_reach
       
        while true
            p = api.api(nil)
            if p >= reach
                email(p)
                reach, fall = calc_fall_reach
            elsif p <= fall
                email(p)
                reach, fall = calc_fall_reach
            end
        sleep(3600)
        end
    
    end

    def email(message)

        message = message.to_s #need to be a string to send in email
        from = ENV['FROM']
        to = ENV['TO']
        pass = ENV['KEY'] #gmail needs a custom pass created for apps

        smtp = Net::SMTP.new('smtp.gmail.com', 587)
        smtp.start('received-from-goes-here', from, pass, :plain)
        smtp.send_message(message, from, to)
        smtp.finish()
    end

end