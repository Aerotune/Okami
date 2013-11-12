require_relative 'drawable'

class Okami::Sprite
  include Okami::Drawable
  AnimationModes = [:forward, :loop, :backward, :backward_loop, :ping_pong]

  attr_reader :image, :images, :last_frame_index
  
  def initialize options
    raise_possible_errors options
    options[:animation_mode] ||= :loop
    
    options.each do |key, value|
      send "#{key}=", value
    end
    
    set_initial_frame_index
    init_drawable
    update_current_image
  end
  
  def fps;      @delta_frame_index * 60.0         end
  def fps=fps;  @delta_frame_index = fps / 60.0   end
  
  def update
    case @direction
    when :forward  then @frame_index += @delta_frame_index*$window.dt*60.0
    when :backward then @frame_index -= @delta_frame_index*$window.dt*60.0
    end
    
    @update_method.call
    update_current_image
  end
  
  
  def finished?
    case @animation_mode
    when :forward;  @frame_index == @last_frame_index
    when :backward; @frame_index == 0
    end
  end
  alias animation_finished? finished?
  
  attr_reader :animation_mode
  def animation_mode= symbol
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
      puts "Supported AnimatedSprite animation modes:"
      puts AnimationModes
      raise ArgumentError, "AnimatedSprite, animation_mode #{symbol.inspect} not supported"
    end
    
    @animation_mode = symbol
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
  
  protected
  
  def images=images
    @images = images
    @last_frame_index  = @images.length - 1
  end
  
  def direction=direction
    @direction = direction
  end
  
  private
  
  def set_initial_frame_index
    case @direction
    when :forward  then @frame_index = 0
    when :backward then @frame_index = @last_frame_index+0.999
    end
  end
  
  def use_update method; @update_method = method end
  def update_current_image; @image = @images[@frame_index] end
    
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
      if @frame_index >= @last_frame_index+0.5
        @direction = :backward
        @frame_index = @last_frame_index+0.5
      end
      
    when :backward
      if @frame_index < 0.5
        @frame_index = 0.5
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