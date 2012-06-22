require 'test/unit'
require_relative 'rover'

class TestPosition< Test::Unit::TestCase

   def setup
      @pos = Position.new(5,7,'N')
   end

   def test_position
     assert_equal(5, @pos.x)
     assert_equal(7, @pos.y)
     assert_equal('N', @pos.bearing)

     assert_not_equal(2, @pos.x)
     assert_not_equal(6, @pos.y)
     assert_not_equal('E', @pos.bearing)
   end

   def test_position_to_s
     assert_equal("5 7 N", @pos.to_s)
   end
end

class TestRover < Test::Unit::TestCase

   def setup
     @rover = Rover.new(Position.new(1,2,'N'), Surface.new(5,5))
   end

   def test_move
     assert_equal(Position.new(1,3,'N').to_s, @rover.move.to_s)
   end

   def test_change_direction
     assert_equal(Position.new(1,2,'E').to_s, @rover.change_direction('R').to_s)
     assert_equal(Position.new(1,2,'S').to_s, @rover.change_direction('R').to_s)
     assert_equal(Position.new(1,2,'W').to_s, @rover.change_direction('R').to_s)
     assert_equal(Position.new(1,2,'N').to_s, @rover.change_direction('R').to_s)

     assert_equal(Position.new(1,2,'W').to_s, @rover.change_direction('L').to_s)
     assert_equal(Position.new(1,2,'S').to_s, @rover.change_direction('L').to_s)
     assert_equal(Position.new(1,2,'E').to_s, @rover.change_direction('L').to_s)
     assert_equal(Position.new(1,2,'N').to_s, @rover.change_direction('L').to_s)
   end
end

