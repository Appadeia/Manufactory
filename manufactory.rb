#!/usr/bin/env ruby

require 'gtk3'
require 'gdk3'

$provider = Gtk::CssProvider.new
Gtk::StyleContext.add_provider_for_screen(
    Gdk::Screen.default,
    $provider,
    900
)
css = File.read "resources/css/manufactory.css"
# $provider.load_from_data css

# settings = Gtk::Settings.default
# settings.set_property "gtk-theme-name", "Adwaita"
# settings.set_property "gtk-application-prefer-dark-theme", true

builder = Gtk::Builder.new
builder.add_from_file "resources/ui/welcome.glade"

def reloadCss()
    css = File.read "resources/css/manufactory.css"
    $provider.load_from_data css
end

window = builder.get_object "Welcome"
window.show_all

Gtk.main
