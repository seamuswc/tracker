
require 'uri'
require 'net/http'
require 'openssl'
require "json"
require 'thread'
require 'byebug'
require 'nokogiri'
require 'open-uri'


require_relative "globals"
require_relative "coin/api"
require_relative "coin/file"
require_relative "coin/threads"
require_relative "coin/calc_interest"
require_relative "nft/main"
require_relative "stock/api"
require_relative "math/math"
require_relative "commands"


coin_file = File.expand_path("../coin/coin.json",__FILE__)
if !File.exists?(coin_file)
    File.open(coin_file, "w+") {|f| f.write("{}") }
end

nft_file = File.expand_path("../nft/list.json",__FILE__)
if !File.exists?(nft_file)
    File.open(nft_file, "w+") {|f| f.write("{}") }
end

price_file = File.expand_path("../coin/prices.txt",__FILE__)
a = File.open(price_file, "w+")
a.close



if ARGV[0] == "total"
    puts File_Coin.new.total
end

ARGV.clear

while true
    command(gets.chomp)
end


