class Okami::Image < Gosu::Image
  @tileable = true
  @load_path = ""
  
  class << self
    Images = {}
    ImageTiles = {}
    
    # Set this for a default value for wether the images should be tileable or not
    attr_accessor :tileable
    # The directory to load the images from
    attr_accessor :load_path
  
    def new path, tileable=@tileable, *src_rect
      super $window, @load_path + path, tileable, *src_rect
    end

    def new_tiles path, tile_width, tile_height, tileable=@tileable             
      super $window, @load_path + path, tile_width, tile_height, tileable
    end
  
    # require / [] will cache the images so they're only loaded once.
    def require path, tileable=@tileable, *src_rect
      Images[ @load_path + path + src_rect.to_s ] ||= load path, tileable, *src_rect
    end
    alias [] require
    
    def require_tiles path, tile_width, tile_height, tileable=@tileable
      ImageTiles[ "size:#{tile_width},#{tile_height}&" + @load_path + path ] ||= load_tiles path, tile_width, tile_height, tileable
    end
      
  end
end
