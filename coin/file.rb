
class File_Coin

    def initialize
        @file = File.expand_path("../coin.json",__FILE__)
    end
        
    def print_list()
        file = File.read(@file)
        data_hash = JSON.parse(file)
        data_hash.each do |k,v| 
            puts "#{v}"
        end
    end

    def delete_from_list()
        file = File.read(@file)
        data_hash = JSON.parse(file)
        data_hash.each do |k,v| 
            puts "#{k}: #{v}"
        end

        puts "Select by number to delete or type 'none' to exit\n"
        coin = gets.chomp

        if coin == "none" || coin == "exit" then return end

        int = coin.to_i

        if int == 0 then return end
        if int > 0 and int <= data_hash.size then
            data_hash.delete(coin)
            
            
            #re-order it
            j = {}
            i = 1
            data_hash.each do |k,v| 
                j[i] = v
                i+=1
            end



            File.write(@file, JSON.dump(j))
        end

    end

    def append_list()
        puts "What would you like to add?\n"
        coin = gets.chomp.strip
        puts "how many?\n"
        num = gets.chomp
        if coin == "none" || coin == "exit" then return end
        num = num.to_i

        file = File.read(@file)
        data_hash = JSON.parse(file)
        

        #loop if check if key already exists
        skip = false
        data_hash.each do |k, v|
            if v[0] == coin
                v[1] += num
                skip = true
            end
        end

        if !skip
            size = data_hash.size + 1
            data_hash[size] = [coin, num]
        end


        File.write(@file, JSON.dump(data_hash))
    end

    def total(sms = nil)
        sms_text = ""
        total_price = 0
        file = File.read(@file)
        data_hash = JSON.parse(file)
        threads = []
        data_hash.each do |k,v| 
            threads << Thread.new {
                api_o = Api.new
                coin = v[0]
                amount = v[1]
                price =  api_o.api(v[0]) * amount
                total_price += price
                sms_text << "#{amount} #{coin} is: #{price}. \n"
            }
        end
        threads.each(&:join)    
        sms_text << "SUM: #{total_price} \n"
        return sms_text if sms.nil?
        return total_price if !sms.nil?
    end


    def max
        price_file = File.open(File.expand_path("../prices.txt",__FILE__), "r")
        price_file.rewind
        begin
            num = price_file.read.split.max
        rescue
            price_file.close
            return "wait until more loops occur"
        end

        price_file.close
        return "wait until more loops occur" if num.nil?
        return num
    end

    def min
        price_file = File.open(File.expand_path("../prices.txt",__FILE__), "r")
        price_file.rewind
        begin
            num = price_file.read.split.min
        rescue
            price_file.close
            return "wait until more loops occur"
        end
        price_file.close
        return "wait until more loops occur" if num.nil?
        return num
    end

    

end