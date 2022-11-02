class Api

    def api(coin)
        coin ||= $coin
        url = URI("https://api.coinbase.com/v2/prices/#{coin}-USD/buy")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(url)
        request["accept"] = 'application/json'
        begin
            response = http.request(request)
        rescue
            puts "bad request"
            return nil
        end
        parsed = JSON.parse(response.body) # returns a hash
        #add error checking
        begin
            price = parsed["data"]["amount"]
        rescue
            puts "api error"
            return -1
        end
        if $spread_on == true and coin.nil?
            spread_check(price.to_f)
        end
        return price.to_f
    end


    def coin(array)
        if array[1].nil?
            puts "Current coin is: #{$coin}"
        else
            $coin = array[1]
            puts api(nil)
        end
    end

end