#!/usr/bin/env ruby
require 'httparty'
require 'base64'

require './code/keyring'

def check_login(api, user, pass)
    response = HTTParty.get(
        api + "/configuration", 
        basic_auth: {username: user, password: pass}
    )
    puts response.code
    if response.code == 200
        keyring_store_user_pass(api, user, pass)
        return true
    else
        return false
    end
end