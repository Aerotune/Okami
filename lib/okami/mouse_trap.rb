module Okami
  module MouseTrap
    class << self
      def capture
        @captured ? false : @captured = true
      end
    
      def release
        @captured = false
        return true
      end
    
      def captured?
        @captured
      end
    end
  end
end