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
        begin
            parsed = JSON.parse(response.body) #returns a hash
        rescue
        end
        #add error checking
        begin
            price = parsed["data"]["amount"]
        rescue
        end

        
        if $spread_on == true
            #byebug
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

    def address()
        puts "Enter Ethereum Address\n"
        address = gets.chomp
        begin
            doc = Nokogiri::HTML(URI.open("https://etherscan.io/address/#{address}"))
        rescue 
            return "Page or Address not found, try again, im retarded"
        end

        element = doc.css("h4.text-cap.mb-1")[1]
        div = element.parent
        eth = div.text.split(" ")[2]
        text = doc.at_css('button#dropdownMenuBalance').text
        return "ETH: #{eth} , TOKENS: #{text.split("\n")[1]}"
    end

end