require_relative 'wrapping_angle'

module Okami::Drawable
  @default_center_x = 0
  @default_center_y = 0
  
  class << self
    attr_accessor :default_center_x, :default_center_y
  end
  
  attr_accessor :x, :y, :z
  attr_accessor :factor_x, :factor_y
  attr_accessor :center_x, :center_y
  attr_accessor :color, :draw_mode
  
  def init_drawable
    @factor_x = 1
    @factor_y = 1
    self.center_x = Okami::Drawable.default_center_x
    self.center_y = Okami::Drawable.default_center_y
    @x = 0
    @y = 0
    @z = 0
    @wrapping_angle = WrappingAngle.new
    @wrapping_angle.degrees = 0
    @degrees = @wrapping_angle.degrees
    @color = 0xFFFFFFFF
    @draw_mode = :default
    @color = Gosu::Color.argb(255, 255, 255, 255)
    @alpha = 1.0
  end
  
  def draw
    @image.draw_rot @x, @y, @z, @degrees, @center_x, @center_y, @factor_x, @factor_y, @color, @draw_mode
  end
  
  def rotate_radians  a; @wrapping_angle.rotate_radians  a; @degrees = @wrapping_angle.degrees  end
  def rotate_fraction a; @wrapping_angle.rotate_fraction a; @degrees = @wrapping_angle.degrees  end
  def rotate_degrees  a; @wrapping_angle.rotate_degrees  a; @degrees = @wrapping_angle.degrees  end
  
  def radians;  @wrapping_angle.radians    end
  def fraction; @wrapping_angle.fraction   end
  def degrees;  @wrapping_angle.degrees    end
  
  def radians=  a; @wrapping_angle.radians  = a; @degrees = @wrapping_angle.degrees  end
  def fraction= a; @wrapping_angle.fraction = a; @degrees = @wrapping_angle.degrees  end
  def degrees=  a; @wrapping_angle.degrees  = a; @degrees = @wrapping_angle.degrees  end
    
  attr_reader :alpha
  def alpha=a
    @alpha = a
    @color.alpha = a*255
  end

  def argb= a, r, g, b
    @color.alpha  = a * 255
    @color.red    = r * 255
    @color.green  = g * 255
    @color.blue   = b * 255
  end
  
  def rgba= r, g, b, a
    @color.red    = r * 255
    @color.green  = g * 255
    @color.blue   = b * 255
    @color.alpha  = a * 255
  end
  
  def rgb=
    @color.red    = r * 255
    @color.green  = g * 255
    @color.blue   = b * 255
  end
end