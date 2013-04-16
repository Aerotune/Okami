require_relative 'drawable'

class Okami::Image
  include Okami::Drawable
  
  def initialize image_path
    @image = Okami::ImageCache[image_path]
    init_drawable
  end
  
  @tileable = true
  @load_path = ""
  
  class << self
    # Set this for a default value for wether the images should be tileable or not
    attr_accessor :tileable
    # The directory to load the images from
    attr_accessor :load_path
    
    def load_path=val
      val << "/" unless val[-1] == "/"
      @load_path = val
    end
  end
end