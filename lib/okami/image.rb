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
    
    def load_path=val
      val << "/" unless val[-1] == "/"
      @load_path = val
    end
    
    ## Doesn't have anything to do with the caching, is the same as Gosu::Image.new
    def new path, tileable=@tileable, *src_rect
      super $window, @load_path + path, tileable, *src_rect
    end
    alias load new
    
    ## Doesn't have anything to do with the caching, is the same as Gosu::Image.load_tiles
    def load_tiles path, tile_width, tile_height, tileable=@tileable             
      super $window, @load_path + path, tile_width, tile_height, tileable
    end
  
    ## Will cache the images so they're only loaded once.
    def require path, tileable=@tileable, *src_rect
      Images[ @load_path + path + src_rect.to_s ] ||= load path, tileable, *src_rect
    end
    alias [] require
    
    def require_tiles path, tile_width, tile_height, tileable=@tileable
      ImageTiles[ "size:#{tile_width},#{tile_height}&" + @load_path + path ] ||= load_tiles path, tile_width, tile_height, tileable
    end
    
    ## Will update the cache
    def reload path, tileable=@tileable, *src_rect
      Images[ @load_path + path + src_rect.to_s ] = load path, tileable, *src_rect
    end
    alias [] require
    
    def reload_tiles path, tile_width, tile_height, tileable=@tileable
      ImageTiles[ "size:#{tile_width},#{tile_height}&" + @load_path + path ] = load_tiles path, tile_width, tile_height, tileable
    end
    
    def retrofy
      Gosu::enable_undocumented_retrofication \
      rescue puts "Unable to use Gosu::enable_undocumented_retrofication"
    end
      
  end
end
