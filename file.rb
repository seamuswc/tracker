

def print_list()
    file = File.read(@fileName)
    data_hash = JSON.parse(file)
    data_hash.each do |k,v| 
        puts "#{v}"
    end
end

def delete_from_list()
    file = File.read(@fileName)
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



        File.write(@fileName, JSON.dump(j))
    end

end

def append_list()
    puts "What would you like to add?\n"
    coin = gets.chomp
    puts "how many?\n"
    num = gets.chomp
    if coin == "none" || coin == "exit" then return end
    file = File.read(@fileName)
    data_hash = JSON.parse(file)
    size = data_hash.size + 1
    data_hash[size] = [coin, num]
    File.write(@fileName, JSON.dump(data_hash))
end

def total
    sms_text = ""
    total_price = 0
    file = File.read('coin.json')
    data_hash = JSON.parse(file)
    data_hash.each do |k,v| 
        coin = v[0]
        amount = v[1]
        price =  api(v[0]) * amount.to_i
        total_price += price
        sms_text << "#{amount} #{coin} is: #{price}. \n"
    end
    sms_text << "SUM: #{total_price} \n"
    return sms_text
end