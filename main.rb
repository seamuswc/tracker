
require 'uri'
require 'net/http'
require 'openssl'
require "json"
require 'thread'
require 'byebug'

require_relative "globals"
require_relative "coin/api"
require_relative "coin/file"
require_relative "coin/threads"
require_relative "coin/calc_interest"
require_relative "nft/main"
require_relative "commands"



if !File.exists?("coin/coin.json")
    File.open("coin/coin.json", "w+") {|f| f.write("{}") }
end
if !File.exists?("nft/list.json")
    File.open("nft/list.json", "w+") {|f| f.write("{}") }
end

if ARGV[0] == "total"
    puts File_Coin.new.total
end

ARGV.clear

while true
    command(gets.chomp)
end


