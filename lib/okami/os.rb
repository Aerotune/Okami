module Okami::OS
  @@system =
  case RUBY_PLATFORM
  when /darwin/i then :mac
  when /mswin/i  then :windows
  when /linux/i  then :linux
  else                :unknown
  end
  
  class << self
    def system;   @@system                  end
    def to_sym;   @@system                  end
    def to_s;     @@system.to_s.capitalize  end
    def mac?;     @@system == :mac          end
    def windows?; @@system == :windows      end
    def linux?;   @@system == :linux        end
    def unknown?; @@system == :unknown      end
  end
end