class Okami::Sprite
  attr_reader :image, :images, :last_frame_index
  
  @@modes = {
    loop:          {direction: :forward,  update_method: :update_loop},
    backward_loop: {direction: :backward, update_method: :update_backward_loop},
    reverse_loop:  {direction: :backward, update_method: :update_backward_loop},
    forward:       {direction: :forward,  update_method: :update_forward},
    backward:      {direction: :backward, update_method: :update_backward},
    reverse:       {direction: :backward, update_method: :update_backward},
    ping_pong:     {direction: :_forward, update_method: :update_ping_pong}
  }
  def self.modes; @@modes end
    
  def initialize options
    raise_possible_errors options
    
    self.images         = options[:images]
    self.fps            = options[:fps]
    self.frame_index    = options[:frame_index] if options[:frame_index]
    self.mode = options[:mode] || :loop
    
    set_initial_frame_index
    update_current_image
    
    @@default_dt ||= $window.update_interval / 1000.0    
  end
  
  def draw       *args;            @image.draw       *args            end
  def draw_rot   *args;            @image.draw_rot   *args            end
  def draw_using image_attributes; @image.draw_using image_attributes end
  
  def fps;      @delta_frame_index * 60.0         end
  def fps=fps;  @delta_frame_index = fps / 60.0   end
  
  def update dt=@@default_dt
    case @direction
    when :forward  then @frame_index += @delta_frame_index * dt * 60.0
    when :backward then @frame_index -= @delta_frame_index * dt * 60.0
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
  def mode= name
    mode_config = @@modes[name]
    mode_config or raise_no_mode name
    self.direction =        mode_config[:direction]
    @update_method = method mode_config[:update_method]
    @mode = name
  end
  
  attr_reader :frame_index
  def frame_index= i
    @frame_index = i
    @frame_index = @last_frame_index if @frame_index.abs > @last_frame_index
    @frame_index = 0 if @frame_index < 0
    update_current_image
  end
  
  def random_frame_index
    rand * @images.length
  end
  
  protected
  
  def images=images
    @images = images
    @last_frame_index = @images.length - 1
  end
  
  def direction=direction
    case direction
    when :forward;   @direction   = :forward
    when :backward;  @direction   = :backward
    when :_forward;  @direction ||= :forward
    when :_backward; @direction ||= :backward 
    end
  end
  
  private
  
  def set_initial_frame_index
    case @direction
    when :forward  then @frame_index ||= 0
    when :backward then @frame_index ||= @last_frame_index+0.999
    end
  end
  
  def update_current_image; @image = @images[@frame_index] end
  
  #################
  ## update_methods
  
  def update_loop;          @frame_index %= @images.length  end
  def update_backward_loop; @frame_index %= @images.length  end
  
  def update_backward;  @frame_index = 0                  if @frame_index < 0                 end
  def update_forward;   @frame_index = @last_frame_index  if @frame_index > @last_frame_index end
    
  def update_ping_pong
    case @direction
    when :forward
      if @frame_index >= @last_frame_index+0.5
        @direction    = :backward
        @frame_index  = @last_frame_index+0.5
      end
      
    when :backward
      if @frame_index <= 0.5
        @frame_index  = 0.5
        @direction    = :forward
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
  
  def raise_no_mode symbol
    puts "Supported AnimatedSprite modes:"
    puts @@modes.keys
    raise ArgumentError, "AnimatedSprite, mode #{symbol.inspect} not supported"
  end
end # Okami::Sprite