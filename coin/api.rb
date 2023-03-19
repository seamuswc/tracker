class Api

    def api(coin, quantity = 0)
        
        coin ||= $coin
        quantity ||= 0
        url = URI("https://api.coinbase.com/v2/prices/#{coin}-USD/buy")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(url)
        request["accept"] = 'application/json'
        begin
            response = http.request(request)
        rescue
            return "bad request"
        end
        parsed = JSON.parse(response.body) # returns a hash
        #add error checking
        begin
            price = parsed["data"]["amount"]
        rescue
            return "api error"
        end

        
        if $spread_on == true
            Coin_Threads.new.spread_check(price.to_f)
        end
        
        if quantity.to_f > 0
            return ((price.to_f) * (quantity.to_f)).round(3)
        end

        return price.to_f
    end


    def coin(coin, quantity)
        if coin.nil?
            puts "Current coin is: #{$coin}"
        else
            $spread_on = false
            $coin = coin
            price_file = File.expand_path("../prices.txt",__FILE__)
            file = File.open(price_file, "w+")
            file.close
            puts api(nil, quantity.to_f)
        end
    end

end