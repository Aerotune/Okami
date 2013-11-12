require 'gosu'

module Okami
  require_relative 'okami/window'
  require_relative 'okami/keyboard'
  require_relative 'okami/mouse'
  require_relative 'okami/image'
  require_relative 'okami/image_tiles'
  require_relative 'okami/image_attributes'
  require_relative 'okami/sprite'
  
  def self.retrofy
    Gosu::enable_undocumented_retrofication \
    rescue puts "Unable to use Gosu::enable_undocumented_retrofication"
  end
end