require_relative 'wrapping_angle'

class Okami::ImageAttributes
  @default_center_x = 0
  @default_center_y = 0
  @default_x = 0
  @default_y = 0
  @default_z = 0
  @default_angle = 0
  
  class << self
    attr_accessor :default_center_x, :default_center_y, :default_x, :default_y, :default_z, :default_angle
  end
  
  attr_accessor :x, :y, :z
  attr_accessor :factor_x, :factor_y
  attr_accessor :center_x, :center_y
  attr_accessor :color, :mode
  
  def initialize options
    @x = options[:x] || self.class.default_x
    @y = options[:y] || self.class.default_y
    @z = options[:z] || self.class.default_z
    
    @wrapping_angle = Okami::WrappingAngle.new
    @wrapping_angle.degrees = options[:angle] || self.class.default_angle
    @degrees = @wrapping_angle.degrees
    
    @center_x = options[:center_x] || self.class.default_center_x
    @center_y = options[:center_y] || self.class.default_center_y
    @factor_x = options[:factor_x] || 1
    @factor_y = options[:factor_y] || 1    
    
    @color     = options[:color]     || Gosu::Color.argb(255, 255, 255, 255)
    @mode = options[:mode] || :default
  end
  
  def to_a
    return @x, @y, @z, @degrees, @center_x, @center_y, @factor_x, @factor_y, @color, @mode
  end
  
  alias :draw_rot_parameters :to_a
  
  def rotate_radians  a; @wrapping_angle.rotate_radians  a; @degrees = @wrapping_angle.degrees  end
  def rotate_fraction a; @wrapping_angle.rotate_fraction a; @degrees = @wrapping_angle.degrees  end
  def rotate_degrees  a; @wrapping_angle.rotate_degrees  a; @degrees = @wrapping_angle.degrees  end
  
  def radians;  @wrapping_angle.radians    end
  def fraction; @wrapping_angle.fraction   end
  def degrees;  @wrapping_angle.degrees    end
  alias :angle :degrees 
  
  def radians=  a; @wrapping_angle.radians  = a; @degrees = @wrapping_angle.degrees  end
  def fraction= a; @wrapping_angle.fraction = a; @degrees = @wrapping_angle.degrees  end
  def degrees=  a; @wrapping_angle.degrees  = a; @degrees = @wrapping_angle.degrees  end
  alias :angle= :degrees=
end