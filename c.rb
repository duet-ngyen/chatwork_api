require "chatwork"

# Create message
ChatWork.api_key = "TOKEN_KEY"
#ChatWork::Message.create(room_id: 36473455, body: "[To:1233972] Hello, ChatWork!")
#host_name = "https://api.chatwork.com/1546609"
host_name = "https://api.chatwork.com/v1/rooms"
data = Kernel.system "curl -i -H  'X-ChatWorkToken:TOKEN_KEY' #{host_name}"
puts data


#
#require 'rss'
#require 'net/https'
#require 'json'
# 
#CW_API_TOKEN = "TOKEN_KEY"
# 
#def get_room
#  uri = URI('https://api.chatwork.com/v1/contacts')
#  http = Net::HTTP.new(uri.host, uri.port)
#  http.use_ssl = true
#  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
# 
#  header = { "X-ChatWorkToken" => CW_API_TOKEN }
#  body = nil
# 
#  res = http.get(uri, header)
#  puts JSON.parse(res.body)
#end
# 
#get_room
