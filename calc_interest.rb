
def calc(arg = nil)

    if Thread.list.length > 1 && arg != "force"
        puts "There is a thread running, we recommend you stop it to run this command\n
        if you want to run when other threads are going use **calc force**"
        return
    end

    #user input for coin
    puts "Deposited Coin"
    d_coin = gets.chomp
    puts "How Many Of Deposited Coin"
    d_amount = gets.chomp
    d_amount = d_amount.to_i

    puts "Earn Coin"
    e_coin = gets.chomp

    puts "interest"
    i = gets.chomp
    i=i.to_f
    i = i * 0.01

    puts "time in months"
    t = gets.chomp
    t = t.to_f
    t = t / 12.0;

    deposited_coin_price = api(d_coin)
    earned_coin_price = api(e_coin)

    #principle * rate * time
    x = (d_amount * deposited_coin_price) * i * t

    puts "After #{t} years at #{i}% you will have #{x}"
    puts "This is #{x / earned_coin_price} #{e_coin}"
    
end