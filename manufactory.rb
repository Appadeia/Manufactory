#!/usr/bin/env ruby

require 'gtk3'
require 'gdk3'

require './code/welcome'
require './code/mainwindow'
require './code/keyring'

$provider = Gtk::CssProvider.new
Gtk::StyleContext.add_provider_for_screen(
    Gdk::Screen.default,
    $provider,
    900
)
css = File.read "resources/css/manufactory.css"
settings = Gtk::Settings.default
settings.set_property "gtk-theme-name", "Adwaita"
settings.set_property "gtk-application-prefer-dark-theme", true
settings.set_gtk_font_name "Cantarell 11"

$provider.load_from_data css

if keyring_get_user_pass() == nil
    login = show_login_window
    login[0].show
else
    main = show_main_window
    main[0].maximize
    main[0].show
end

Gtk.main
