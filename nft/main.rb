
class Nft

    def initialize
        @file = File.expand_path("../list.json",__FILE__)
    end

    $thr = []

    def api(nft) 
        begin
            url = URI("https://api.opensea.io/collection/#{nft}")
            #URI? check to prevent program crash
        rescue
            puts "NFT URL not found"
            return
        end
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(url)
        res = http.request(request)

        if res.code == "200"
            parsed = JSON.parse(res.body)
            return parsed["collection"]["stats"]["floor_price"]
        else
            puts "couldnt find nft"
        end

    end

    def read_list()
        file = File.read(@file)
        data_hash = JSON.parse(file)

        data_hash.each do |k,v| 
            puts "#{k}: #{v}"
        end

        puts "Select nft by number to see floor or type 'none' to exit\n"
        nft = gets.chomp

        if nft == "none" || nft == "exit" then return end
        
        int = nft.to_i
        if int == 0 then return end
        if int > 0 and int <= data_hash.size then
            res = api(data_hash[nft])
            puts res
        end

    end

    def print_list()
        file = File.read(@file)
        data_hash = JSON.parse(file)
        data_hash.each do |k,v| 
            res = api(data_hash[k])
            puts "#{v}: #{res}"
        end
    end

    def delete_from_list()
        file = File.read(@file)
        data_hash = JSON.parse(file)
        data_hash.each do |k,v| 
            puts "#{k}: #{v}"
        end

        puts "Select nft by number to delete or type 'none' to exit\n"
        nft = gets.chomp

        if nft == "none" || nft == "exit" then return end

        int = nft.to_i

        if int == 0 then return end
        if int > 0 and int <= data_hash.size then
            data_hash.delete(nft)
            
            
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
        puts "Which nft would you like to add?\n"
        nft = gets.chomp
        if nft == "none" || nft == "exit" then return end
        file = File.read(@file)
        data_hash = JSON.parse(file)
        size = data_hash.size + 1
        data_hash[size] = nft
        File.write(@file, JSON.dump(data_hash))
    end

    def loop_list() 
        if($thr.length >=1)
            puts "Loop already running"
            return
        end

        puts "Loop repeat after how many seconds?\n"
        t = gets.chomp
        if t == "none" || t == "exit" then return end
        t = t.to_i

        $thr << Thread.new { 
            while true
                print_list
                sleep t
            end
        }
    end

    def stop()
        if $thr.length >= 1
            Thread.kill($thr.first)
            $thr.pop
        end
    end

    def punks()
        begin
            doc = Nokogiri::HTML(URI.open("https://www.larvalabs.com/cryptopunks"))
        rescue 
            return "Punks not found"
        end
        text = doc.css('.punk-stat').css('b')[0].text
        price = text.split[0]
        return price.to_f
    end


   

end