class Surface
  attr_accessor :max_x,:max_y
  @rovers = {}

  def initialize(x,y)
    @max_x = x
    @max_y = y
  end
  
  def register_rover rover
    raise "RoverOutOfSurfaceBoundsException" if f rover.position.x > max_x or rover.position.y > max_y
    @rovers[rover]= rover.position
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
  attr_accessor :position 

  def initialize(position)
    @position = position
  end

  def move
    case position.bearing
    when 'N' then  position.y= position.y + 1
    when 'S' then  position.y= position.y - 1
    when 'E' then  position.x= position.x + 1
    when 'W' then  position.x= position.x - 1
    end  
    position
  end
  
  def change_direction(new_direction)
    current_bearing_index = @@bearings.index(position.bearing)
    if new_direction == 'R'
      if @@bearings[current_bearing_index] == 'W' 
         position.bearing= 'N'
      else
         position.bearing= @@bearings[current_bearing_index+1]         
      end
    else #for new_direction == 'L' 
      if @@bearings[current_bearing_index] == 'N'
         position.bearing= 'W'
      else
         position.bearing= @@bearings[current_bearing_index-1]
      end  
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

plateau = Surface.new(5,5)
mars_rover = Rover.new(Position.new(1,2,'N'))
mars_rover.control('LMLMLMLMM')
puts mars_rover.position

mars_rover = Rover.new(Position.new(3,3,'E'))
mars_rover.control('MMRMMRMRRM')
puts mars_rover.position


