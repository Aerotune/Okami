Okami::Images = {}

class Okami::ImageCache
  class << self    
    ## Will cache the images so they're only loaded once.
    def require path, tileable=Okami::Image.tileable, *src_rect
      path = Okami::Image.load_path + path
      Okami::Images[ path + src_rect.to_s ] ||= Gosu::Image.new $window, path, tileable, *src_rect
    end
    alias [] require
    
    ## Will load and cache even if it's already cached
    def load path, tileable=Okami::Image.tileable, *src_rect
      path = Okami::Image.load_path + path
      Okami::Images[ path + src_rect.to_s ] = Gosu::Image.new $window, path, tileable, *src_rect
    end
  end
end
