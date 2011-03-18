require_relative 'test_helper'

class RobotsVSLasersTest < Test::Unit::TestCase
  def setup
    RobotsVSLasers.stubs( :db_path ).returns( FIXTURES_PATH )
  end
  
  def test_run
    result = [
      'GO WEST',
      'GO EAST',
      'GO WEST'
    ]
    
    assert_equal( result, RobotsVSLasers.run )
  end
end