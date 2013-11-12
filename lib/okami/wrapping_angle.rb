class Okami::WrappingAngle  
  Tau = Math::PI * 2
  
  def initialize options={}
    self.fraction = options[:fraction]  if options.has_key? :fraction
    self.degrees  = options[:degrees]   if options.has_key? :degrees
    self.radians  = options[:radians]   if options.has_key? :radians
    @radians ||= 0
  end
  
  def radians;  @radians                end
  def fraction; @radians / Tau          end
  def degrees;  @radians / Tau * 360.0  end
  
  def radians=  a; @radians =  a % Tau                    end
  def fraction= a; @radians = (a % 1.0   ) * Tau          end
  def degrees=  a; @radians = (a % 360.0 ) / 360.0 * Tau  end
  
  ### Displaying
  #begin
  #  require 'fraction'
  #  def pretty_angle unit=@standard_unit
  #    case unit
  #    when :degrees
  #      "#{angle(:degrees).round}°"
  #    when :fraction, :radians
  #      nom, den = angle(:fraction).fraction
  #      return "0τ" if nom == 0
  #      return "#{nom}/#{den}τ"
  #    end
  #  end
  #rescue LoadError
  #  def pretty_angle unit=@standard_unit
  #    case unit
  #    when :degrees;  "#{angle(:degrees).round}°"
  #    when :radians; "#{angle(:radians)} radians"
  #    when :fraction;  "#{angle(:fraction)}"
  #    end
  #  end
  #end
  
end