MouseTrap = Struct.new(:captured)
class << MouseTrap
  def capture
    @captured ? false : @captured = true
  end
  
  def release
    @captured = false
    return true
  end
  
  def captured?; !!@captured end
  def released?; !@captured  end
end