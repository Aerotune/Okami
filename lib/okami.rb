require 'gosu'

module Okami
  require_relative 'okami/window'
  require_relative 'okami/keyboard'
  require_relative 'okami/mouse'
  require_relative 'okami/mouse_trap'
  require_relative 'okami/hit_mask'
  require_relative 'okami/image'
  require_relative 'okami/image_tiles_cache'
  require_relative 'okami/image_cache'
  require_relative 'okami/sprite'
  
  def self.retrofy
    Gosu::enable_undocumented_retrofication \
    rescue puts "Unable to use Gosu::enable_undocumented_retrofication"
  end
end