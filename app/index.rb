require 'sinatra'
require 'uri'
require 'net/http'
require 'openssl'
require "json"
require 'thread'
require 'byebug'

require_relative "../globals"
require_relative "../coin/api"
require_relative "../coin/file"
require_relative "../coin/threads"
require_relative "../coin/calc_interest"
require_relative "../nft/main"
require_relative "../commands"

  
get '/*' do
  if (params.first[1]) == "total"
    @var = File_Coin.new.total
  end
  erb :index
end



  