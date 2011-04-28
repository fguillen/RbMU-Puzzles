module Utils  
  def self.active_lasers( robot_position, north_lasers, south_lasers )
    active_lasers_sequence = ""
    
    selector = even?( robot_position ) ? [north_lasers, south_lasers] : [south_lasers, north_lasers]
    
    (0..(north_lasers.length - 1)).each do |index|
      active_lasers_sequence += selector[index % 2][index]
    end
    
    return active_lasers_sequence
  end
  
  def self.damages( robot_position, active_lasers_sequence )
    west_damages = active_lasers_sequence[0..robot_position].count( '|' )
    east_damages = active_lasers_sequence[robot_position..-1].count( '|' )
    
    return [west_damages, east_damages]
  end

  def self.robot_position( conveyor_belt )
    conveyor_belt.index( 'X' )
  end
  
  def self.split_entities( conveyor_layout )
    entities = {
      :north_lasers  => conveyor_layout.split( "\n" )[0].strip,
      :conveyor_belt => conveyor_layout.split( "\n" )[1].strip,
      :south_lasers  => conveyor_layout.split( "\n" )[2].strip
    }

    return entities
  end
  
  def self.split_conveyor_layouts( conveyor_layouts_grid )
    conveyor_layouts_grid.split( "\n\n" )
  end
  
  def self.even?( number )
    number % 2 == 0
  end
  
  def self.best_direction( west_damages, east_damages )
    return ( (west_damages <= east_damages) ? :west : :east )
  end
end