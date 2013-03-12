## The image of the hitmask, white is hitpoints, black is not
require 'texplay'

class Okami::HitMask  
  def initialize mask, parent
    @hit_mask = mask
    @parent = parent
  end
  
  def hit_point? x, y
    c = @hit_mask.get_pixel( x - @parent.x, y - @parent.y )
    return false unless c
    return c[1] > 0.9 # quick 'n dirty
  end
  
  def hit_line x1, y1, x2, y2
    hit_vertex = @hit_mask.line x1, y1, x2, y2, trace: { :until_color => :white, :tolerance => 0.1 }
    hit_vertex || false
  end
end