

class Stock

    def api(ticker = "COIN", quantity = 0)
        ticker&.upcase!
        ticker ||= "COIN"
        quantity ||= 0
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

end