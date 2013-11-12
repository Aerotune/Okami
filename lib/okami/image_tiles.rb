module Okami::ImageTiles
  class << self
    def require *args
      Okami::Image.require_tiles *args
    end
    alias [] require
  
    def load *args
      Okami::Image.load_tiles *args
    end
  end
end