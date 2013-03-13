require 'texplay'

class Okami::HitMask
  ## The mask is of the type Image, white is hitpoints, black is not
  def initialize mask, parent
    @hit_mask = mask
    @parent = parent
  end
  
  def hit_point? x, y
    c = @hit_mask.get_pixel( x - @parent.x, y - @parent.y )
    return false unless c
    return c[1] > 0.9 # quick 'n dirty
  end
  
  def hit_line? x1, y1, x2, y2
    !!hit_line( x1, y1, x2, y2 )
  end
  
  # Returns an array with the coordinates of the first hit point [x,y] or nil if it doesn't hit
  def hit_line x1, y1, x2, y2
    hit_vertex = @hit_mask.line x1, y1, x2, y2, trace: { :until_color => :white, :tolerance => 0.1 }
    hit_vertex ? hit_vertex[0..1] : nil
  end
end