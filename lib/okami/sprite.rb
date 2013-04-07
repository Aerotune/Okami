class Okami::Sprite
  Modes = [:forward, :loop, :backward, :backward_loop, :ping_pong]

  attr_reader :current_image, :images, :last_frame_index
  
  def initialize options
    raise_possible_errors options
    
    @images = options[:images]
    
    @last_frame_index = @images.length - 1
    @add       = ( options[:fps]  || 0 ) / 60.0
    @direction =   options[:direction]
    self.mode  =   options[:mode] || :loop
    
    case @direction
    when :forward  then @frame_index = 0
    when :backward then @frame_index = @last_frame_index+0.999
    end
    
    update_current_image
  end
  
  def fps; @add * 60.0 end
  def fps= fps; @add = fps / 60.0 end
  
	## Draw it just like a Gosu::Image !
  def draw         *args; @current_image.draw         *args end
  def draw_as_quad *args; @current_image.draw_as_quad *args end
  def draw_rot     *args; @current_image.draw_rot     *args end
  
  
  def update
    case @direction
    when :forward  then @frame_index += @add*$window.dt*60.0
    when :backward then @frame_index -= @add*$window.dt*60.0
    end
    
    @update_method.call
    update_current_image
  end
  
  
  def finished?
    case @mode
    when :forward;  @frame_index == @last_frame_index
    when :backward; @frame_index == 0
    end
  end
  alias animation_finished? finished?
  
  attr_reader :mode
  def mode= symbol
    case symbol
    when :loop
      @direction = :forward
      use_update method :update_loop
      
    when :backward_loop
      @direction = :backward
      use_update method :update_backward_loop
      
    when :forward
      @direction = :forward
      use_update method :update_forward
      
    when :backward
      @direction = :backward
      use_update method :update_backward
      
    when :ping_pong
      @direction ||= :forward
      use_update method :update_ping_pong
      
    else
      puts "Supported AnimatedSprite modes:"
      puts self.class.modes
      raise ArgumentError, "AnimatedSprite, mode #{symbol.inspect} not supported"
    end
    
    @mode = symbol
  end
  
  attr_reader :frame_index
  def frame_index= i
    @frame_index = i
    @frame_index = @last_frame_index if @frame_index.abs > @last_frame_index
    @frame_index = 0 if @frame_index < 0
    update_current_image
  end
  
  def random_frame_index
    (rand()*@images.length)
  end
  
  
  
  private
  
  
  
  def use_update method; @update_method = method end
  def update_current_image; @current_image = @images[@frame_index] end
    
  def update_loop;          @frame_index %= @images.length  end
  def update_backward_loop; @frame_index %= @images.length  end
  
  def update_backward
    @frame_index = 0 if @frame_index < 0
  end
  
  def update_forward
    @frame_index = @last_frame_index if @frame_index > @last_frame_index
  end
  
  
  
  def update_ping_pong
    case @direction
    when :forward
      if @frame_index >= @last_frame_index
        @direction = :backward
        @frame_index = @last_frame_index
      end
      
    when :backward
      if @frame_index < 0
        @frame_index = 0
        @direction = :forward
      end
      
    end
  end
  
  def raise_possible_errors options
    raise ArgumentError, "Sprite.new options must contain option :images" unless options[:images]
    raise TypeError, "Sprite.new option :images must be of type Array"    unless options[:images].kind_of? Array
    raise "Sprite.new option :images is empty"                            if options[:images].empty?
    
    raise ArgumentError, "Sprite.new options must contain option :fps"    unless options[:fps]
    raise TypeError, "Sprite.new option :fps must be of type Numeric"     unless options[:fps].kind_of? Numeric
  end
end # Okami::Sprite