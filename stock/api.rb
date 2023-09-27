
class Stock

    def stock(stock, quantity)
        if stock.nil?
            puts "Current stock is: #{$stock}"
        else
            $stock = stock
            puts api(nil, quantity.to_f)
        end
    end

    def api(ticker, quantity = 0)
        ticker ||= $stock
        ticker&.upcase!
        quantity ||= 0
        #puts ticker
        begin
            doc = Nokogiri::HTML(URI.open("https://finance.yahoo.com/quote/#{ticker}?p=#{ticker}&.tsrc=fin-srch"))
        rescue 
            return "Stock ticker not found"
        end
        #puts doc.css("fin-streamer").count
        price = doc.css('fin-streamer')[18].text

        if quantity.to_f > 0
            return ((price.to_f) * (quantity.to_f))
        end

        return price.to_f
    end

    def gold()
        begin
            doc = Nokogiri::HTML(URI.open("https://www.kitco.com/market/"))
        rescue 
            return "GOLD not found"
        end
        value = doc.at_css('#AU-bid').text
        return value.to_f
    end

end