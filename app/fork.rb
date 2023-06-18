

class Fork 

    def spoon
        pid = fork do
            q = Fork.new
            q.start
        end       
        Process.detach(pid)
    end

    def start
    
        api = Api.new
        base = api.api(nil)
        reach = (base * 0.05) + base

        while true
            p = api.api(nil)
            if p >= reach
                email(p)
                base = p
                reach = (base * 0.05) + base
            end
        sleep(3600)
        end
    
    end

    def email(message)
        message = message.to_s #need to be a string to send in email
        from = "jamesthaiphone@gmail.com"
        to = "seamuswconnolly@gmail.com"
        pass = "nzelczjssktvmpri" #gmail needs a custom pass created for apps

        smtp = Net::SMTP.new('smtp.gmail.com', 587)
        smtp.start('received-from-goes-here', from, pass, :plain)
        smtp.send_message(message, from, to)
        smtp.finish()
    end

end