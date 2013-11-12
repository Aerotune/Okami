Okami::ImageCache = {}
Okami::ImageTileCache = {}

module Okami::DrawMethods
  def draw_using image_attributes
    #draw_rot *image_attributes
    ## or this?
    draw_rot \
    image_attributes.x, 
    image_attributes.y, 
    image_attributes.z, 
    image_attributes.angle, 
    image_attributes.center_x,
    image_attributes.center_y,
    image_attributes.factor_x,
    image_attributes.factor_y,
    image_attributes.color,
    image_attributes.mode
  end
end

class Okami::Image < Gosu::Image
  include Okami::DrawMethods
  
  @tileable = false
  @load_path = './'
  
  class << self
    # Default value for wether the images should be tileable or not
    attr_accessor :tileable
    # The directory to load the images from
    attr_accessor :load_path
    
    def load_path= directory
      if @_load_path_set
        warn "It's best practice that '#{self}.load_path = directory'
        is set only once since the image is cached by the relative path"
      end
      @_load_path_set = true
      @load_path = directory
    end
    
    ## Character::Will cache the images so they're only loaded once.
    def require relative_path, options=nil
      Okami::ImageCache[relative_path] ||
      load(relative_path, options)
    end
    alias [] require
    
    ## Character::Will load and cache even if it's already cached
    def load relative_path, options=nil
      image_path = File.join(@load_path, relative_path)
      
      Okami::ImageCache[relative_path] = 
        if options
          new_by_options options
        else
          new $window, image_path
        end
    end
    
    def new_by_options options
      tileable = options[:tileable] || @tileable
      src_rect = options[:src_rect]
      new $window, image_path, tileable, *src_rect
    end
    
    def require_tiles relative_path,
                      tile_width=nil,
                      tile_height=nil,
                      tileable=@tileable
      Okami::ImageTileCache[relative_path] ||
      load_tiles(relative_path, tile_width, tile_height, tileable)
    end
    
    ## Character::Will load and cache even if it's already cached
    def load_tiles relative_path,
                   tile_width,
                   tile_height,
                   tileable=@tileable
                   
      image_path = File.join(@load_path, relative_path)
      tiles = super $window, image_path, tile_width, tile_height, tileable
      tiles.each { |tile| tile.extend Okami::DrawMethods }
      Okami::ImageTileCache[relative_path] = tiles
    end
  end
end