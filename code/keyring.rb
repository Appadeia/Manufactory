#!/usr/bin/env ruby

require 'yaml'
require 'fileutils'

# not dealing with keyring bullshit because
# there's absolutely zero goddamn fucking documentation
# no stackoverflow, no reddit, no nothing. the gobject binding
# bullshit means that rubydocs doesn't generate proper docs.
# thanks.
#
# so enjoy plaintext password storage because of that

def keyring_store_user_pass(api, user, pass)
    config_path = File.expand_path('~/.config/manufactory')
    config_file = File.expand_path('~/.config/manufactory/passwords.yml')

    unless File.directory?(config_path)
        FileUtils.mkdir_p(config_path)
    end

    hash = {:api => api, :username => user, :password => pass}

    File.open(config_file, 'w') do |out|
        YAML.dump hash, out
    end
end

def keyring_get_user_pass()
    config_file = File.expand_path('~/.config/manufactory/passwords.yml')
    begin
        hash = YAML.load_file(config_file)
        return [hash[:username], hash[:password], hash[:api]]
    rescue => exception
        return nil
    end
end