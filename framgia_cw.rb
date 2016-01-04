require "chatwork"

# Create message
#ChatWork.api_key = "##"
#ChatWork::Message.create(room_id: 36473455, body: "[To:1233972] Hello, ChatWork!")
#host_name = "https://api.chatwork.com/1546609"
#host_name = "https://api.chatwork.com/v1/rooms"
#data = Kernel.system "curl -i -H  'X-ChatWorkToken:1dbfba89d5f71678966a523cb22a160c' #{host_name}"
#puts data


require 'rss'
require 'net/https'
require 'json'
require "csv"

CW_API_TOKEN = "##"

def get_member_room
  uri = URI('https://api.chatwork.com/v1/rooms/5126753/members')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
 
  header = { "X-ChatWorkToken" => CW_API_TOKEN }
  #body = nil
 
  res = http.get(uri, header)
  res.body
end

def name_to_email(name)
  name = name.downcase.gsub!(" ",".").concat("@framgia.com")
end

def convert_to_csv
  json_data = JSON.parse get_member_room
  CSV.open("member.csv", "wb") do |csv|
    csv << ["Name", "account_cw_id", "email"]    
    json_data.each do |row|      
      csv << [row["name"], row["account_id"], name_to_email(row["name"])]
    end 
  end   
end

convert_to_csv
