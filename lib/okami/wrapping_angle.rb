class WrappingAngle  
  Tau = Math::PI * 2
  
  def initialize
    @c = Complex(0,1)
  end
  
  def rotate_radians  a; @c *= Complex(0,1)**(a/Tau * 4)  end
  def rotate_fraction a; @c *= Complex(0,1)**(a*4)        end
  def rotate_degrees  a; @c *= Complex(0,1)**(a/90.0)     end
  
  def radians;  @c.angle              end
  def fraction; @c.angle / Tau        end
  def degrees;  @c.angle / Tau * 360  end
  
  def radians=  a; @c = Complex(0,1)**(a/Tau * 4) end
  def fraction= a; @c = Complex(0,1)**(a*4.0)     end
  def degrees=  a; @c = Complex(0,1)**(a/90.0)    end
  
  ### Displaying
  
  begin
    require 'fraction'
    def pretty_angle unit=@standard_unit
      case unit
      when :degrees
        "#{angle(:degrees).round}°"
      when :fraction, :radians
        nom, den = angle(:fraction).fraction
        return "0τ" if nom == 0
        return "#{nom}/#{den}τ"
      end
    end
  rescue LoadError
    def pretty_angle unit=@standard_unit
      case unit
      when :degrees;  "#{angle(:degrees).round}°"
      when :radians; "#{angle(:radians)} radians"
      when :fraction;  "#{angle(:fraction)}"
      end
    end
  end
  
end