class Okami::Sprite
  Modes = [:forward, :loop, :backward, :backward_loop, :ping_pong]

  attr_reader :current_image, :images, :last_frame_index
  
  def initialize options={}
    @images = options[:images]
    
    @last_frame_index = @images.length - 1
    @add      = ( options[:fps]  || 0 ) / 60.0
    self.mode =   options[:mode] || :loop
    
    case @direction
    when :forward  then @frame_index = 0
    when :backward then @frame_index = @last_frame_index+0.99
    end
    
    update_current_image
  end
  
  def fps; @add * 60 end
  def fps= fps; @add = fps / 60.0 end
  
  attr_reader :frame_index
  def frame_index= i
    @frame_index = i
    @frame_index = @last_frame_index if @frame_index > @last_frame_index
    @frame_index = 0 if @frame_index < 0
    update_current_image
  end
  
  
	## Draw it just like a Gosu::Image !
  def draw         *args; @current_image.draw         *args end
  def draw_as_quad *args; @current_image.draw_as_quad *args end
  def draw_rot     *args; @current_image.draw_rot     *args end
  
  
  def update
    case @direction
    when :forward  then @frame_index += @add
    when :backward then @frame_index -= @add
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
  
  
  
  protected
  
  
  
  def use_update method; @update_method = method end
  
  def update_current_image
    @current_image = @images[ @frame_index ]
  end
  
  def update_forward
    @frame_index = @last_frame_index if @frame_index > @last_frame_index
  end
  
  def update_loop
    @frame_index = 0 if @frame_index >= @last_frame_index
  end
  
  def update_backward
    @frame_index = 0 if @frame_index < 0
  end
  
  def update_backward_loop
    @frame_index = @last_frame_index+0.99 if @frame_index < 0
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
        @frame_index = 1
        @direction = :forward
      end
      
    end
  end
end # Okami::Sprite

=begin
## Example ##
a = AnimatedSprite.new images: [1, 2, 3, 4, 5, 6, 7, 8], fps: 60, :mode => :forward
loop do
  #if rand(10) == 1
  #  modes = AnimatedSprite.modes
  #  a.mode = modes[rand(modes.length)]
  #  puts a.mode
  #end
  p a.current_image
  p a.finished?
  a.update
  sleep 0.3
end
=end