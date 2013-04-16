Okami::ImageTiles = {}

class Okami::ImageTilesCache
  class << self        
    def require path, tile_width, tile_height, tileable=Okami::Image.tileable
      path = Okami::Image.load_path + path
      Okami::ImageTiles[ "size:#{tile_width},#{tile_height}&" + path ] ||= Gosu::Image.load_tiles $window, path, tile_width, tile_height, tileable
    end
    alias [] require
    
    ## Will load and cache even if it's already cached
    def load path, tile_width, tile_height, tileable=Okami::Image.tileable
      path = Okami::Image.load_path + path
      Okami::ImageTiles[ "size:#{tile_width},#{tile_height}&" + path ] = Gosu::Image.load_tiles $window, path, tile_width, tile_height, tileable
    end
  end
end
