#!/usr/bin/env ruby

require 'gtk3'
require 'gdk3'

require './code/loginmanager'
require './code/mainwindow'

$welcome_builder = nil

def show_login_window()
    $welcome_builder = Gtk::Builder.new
    $welcome_builder.add_from_file "resources/ui/login.glade"
    window = $welcome_builder.get_object "Login"

    $welcome_builder.connect_signals { |handler| method(handler) }
    error_icon = $welcome_builder.get_object "ErrorIcon"
    error_icon.hide

    return [window, $welcome_builder]
end

def login_next(args)
    instance = $welcome_builder.get_object "instance"
    loginfield = $welcome_builder.get_object "loginfield"
    password = $welcome_builder.get_object "password"

    if check_login(instance.text, loginfield.text, password.text)
        stack = $welcome_builder.get_object "LoginStack"
        started = $welcome_builder.get_object "LetsGetStartedScreen"
        nextbtn = $welcome_builder.get_object "NextBtn"
    
        nextbtn.hide
    
        stack.set_visible_child started
    else
        error_icon = $welcome_builder.get_object "ErrorIcon"

        error_icon.show
        return
    end
end

def lets_start(args)
    window = $welcome_builder.get_object "Login"
    window.destroy

    main = show_main_window
    main[0].maximize
    main[0].show
end