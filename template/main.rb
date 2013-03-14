#require 'okami'
#require 'okami/image'

require 'bundler'
Bundler.require

require './config/okami'
require './app/window'

Window.new.show