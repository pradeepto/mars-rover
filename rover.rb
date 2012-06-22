class Surface
  attr_accessor :max_x,:max_y
  @rovers = {}

  def initialize(x,y)
    @max_x = x
    @max_y = y
  end
end

class Position
  attr_accessor :x,:y,:bearing

  def initialize(x,y,bearing)
    @x = x
    @y = y
    @bearing = bearing
  end

  def to_s
    "#{x} #{y} #{bearing}"
  end
end

@@bearings = ['N','E','S','W']

class Rover
  attr_accessor :position,:surface

  def initialize(position,surface)
    @position = position
    @surface  = surface
  end

  def check_lower_bound value
    raise "OutOfSurfaceBounds" if value.zero?
  end

  def check_upper_x_bound x
    raise "OutOfSurfaceBounds" if x >= surface.max_x
  end

  def check_upper_y_bound y
    raise "OutOfSurfaceBounds" if y >= surface.max_y
  end

  def move
    case position.bearing
    when 'N' then  check_upper_y_bound(position.y); position.y= position.y + 1
    when 'S' then  check_lower_bound(position.y)  ; position.y= position.y - 1
    when 'E' then  check_upper_x_bound(position.x); position.x= position.x + 1
    when 'W' then  check_lower_bound(position.x)  ; position.x= position.x - 1
    end
    position
  end

  def change_direction(direction)
    current_bearing_index = @@bearings.index(position.bearing)
    if direction == 'R'
       position.bearing= @@bearings[(current_bearing_index + 1) % 4]
    else #for new_direction == 'L'
       position.bearing= @@bearings[(current_bearing_index - 1) % 4]
    end
    position
  end

  def control(commands)
    commands.split("").each do |command|
      if command == 'M'
        move
      else
        change_direction(command)
      end
    end
  end
end

#plateau = Surface.new(5,5)
#mars_rover = Rover.new(Position.new(1,2,'N'),plateau)
#mars_rover.control('LMLMLMLMM')
#puts mars_rover.position
#
#mars_rover = Rover.new(Position.new(3,3,'E'),plateau)
#mars_rover.control('MMRMMRMRRM')
#puts mars_rover.position
#
#mars_rover = Rover.new(Position.new(1,3,'S'),plateau)
#mars_rover.control('MMMMM')
#puts mars_rover.position
#
#
