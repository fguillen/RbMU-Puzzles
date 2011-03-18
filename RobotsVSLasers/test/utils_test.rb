require_relative 'test_helper'

class UtilsTest < Test::Unit::TestCase
  def test_active_lasers
    assert_equal( '###||###', Utils.active_lasers( 0, '###||###', '###||###' ) )
    assert_equal( '###||###', Utils.active_lasers( 1, '###||###', '###||###' ) )
    assert_equal( '###|||##', Utils.active_lasers( 0, '###||###', '###|#|##' ) )
    assert_equal( '###|####', Utils.active_lasers( 1, '###||###', '###|#|##' ) )
    assert_equal( '||||||||', Utils.active_lasers( 0, '||||||||', '||||||||' ) )
    assert_equal( '||||||||', Utils.active_lasers( 4, '||||||||', '||||||||' ) )
    assert_equal( '||||||||', Utils.active_lasers( 5, '||||||||', '||||||||' ) )
    assert_equal( '########', Utils.active_lasers( 0, '#|#|#|#|', '|#|#|#|#' ) )
    assert_equal( '||||||||', Utils.active_lasers( 1, '#|#|#|#|', '|#|#|#|#' ) )
  end
  
  def test_damages
    assert_equal( [0,2], Utils.damages( 0, '###||###' ) )
    assert_equal( [0,2], Utils.damages( 1, '###||###' ) )
    assert_equal( [0,3], Utils.damages( 0, '###|||##' ) )
    assert_equal( [0,1], Utils.damages( 1, '###|####' ) )
    assert_equal( [1,8], Utils.damages( 0, '||||||||' ) )
    assert_equal( [5,4], Utils.damages( 4, '||||||||' ) )
    assert_equal( [6,3], Utils.damages( 5, '||||||||' ) )
    assert_equal( [0,0], Utils.damages( 0, '########' ) )
    assert_equal( [2,7], Utils.damages( 1, '||||||||' ) )
  end
  
  def test_robot_position
    assert_equal( 0, Utils.robot_position( 'X-------' ) )
    assert_equal( 3, Utils.robot_position( '---X----' ) )
    assert_equal( 5, Utils.robot_position( '-----X--' ) )
    assert_equal( 7, Utils.robot_position( '-------X' ) )
  end
  
  def test_split_entities
    conveyor_layout = <<-EOS
      #|#|#|##
      ---X----
      ###||###
    EOS
    
    assert_equal( '#|#|#|##', Utils.split_entities( conveyor_layout )[:north_lasers] )
    assert_equal( '---X----', Utils.split_entities( conveyor_layout )[:conveyor_belt] )
    assert_equal( '###||###', Utils.split_entities( conveyor_layout )[:south_lasers] )
  end
  
  def test_split_conveyor_layouts
    assert_equal( "#|#|#|##\n---X----\n###||###", Utils.split_conveyor_layouts( File.read( "#{FIXTURES_PATH}/input.txt" ) )[0] )
  end
  
  def test_best_direction
    assert_equal( :east, Utils.best_direction( 1, 0 ) )
    assert_equal( :west, Utils.best_direction( 0, 1 ) )
    assert_equal( :west, Utils.best_direction( 1, 1 ) )
  end
end
