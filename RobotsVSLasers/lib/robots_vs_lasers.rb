require_relative 'utils'

module RobotsVSLasers
  DB_PATH = "#{File.dirname(__FILE__)}/../db/"
  
  def self.run
    result = []
    
    conveyor_layouts_grid = File.read( "#{db_path}/input.txt" )
    conveyor_layouts = Utils.split_conveyor_layouts( conveyor_layouts_grid )
    
    conveyor_layouts.each do |conveyor_layout|
      entities = Utils.split_entities( conveyor_layout )
      robot_position = Utils.robot_position( entities[:conveyor_belt] )
      active_lasers = Utils.active_lasers( robot_position, entities[:north_lasers], entities[:south_lasers] )
      damages = Utils.damages( robot_position, active_lasers )
      best_direction = Utils.best_direction( damages[0], damages[1] )
      
      result << ( (best_direction == :west ) ? 'GO WEST' : 'GO EAST' )
    end
    
    return result
  end
  
  def self.db_path
    DB_PATH
  end
end