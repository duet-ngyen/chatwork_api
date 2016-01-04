require 'rubygems'
require 'json'
require 'net/http'

class SynchronizesController < ApplicationController
  respond_to :json
  $usaGovURI = "http://10.0.1.12:3456/api/users/sign_in.json?"
  def index
  end

  def create
    binding.pry
    mail_login_crm = params[:email]
    pass_login_crm = params[:password]
    authenticate_crm = authenticate_crm mail_login_crm, pass_login_crm
    response = authenticate_crm[0]
    email = authenticate_crm[1]["email"]
    token = authenticate_crm[1]["auth_token"]
    if response.is_a? Net::HTTPOK
      sync_data = authenticate_crm[1]
      json_data = JSON.parse(open("http://10.0.1.12:3456/api/periods.json?user_email=#{email}&user_token=#{token}").read)
      json_data.each do |row|
        period = Period.find_by(name: row["name"])
        if period == nil
          Period.create!(row)
        else
          period.update_attributes(row)
        end
      end
    else
    end
    redirect_to synchronizes_path
  end

  private
  def authenticate_crm email, password
    uri = URI.parse($usaGovURI)
    response = Net::HTTP.get_response(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({"user[email]" => email, "user[password]" => password})
    response = http.request(request)
    data = response.body
    authen_info = JSON.parse(data)
    [response, authen_info]
  end
end
