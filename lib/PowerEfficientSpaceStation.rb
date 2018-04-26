# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "Transformation"
require_relative "SpaceStation"

module Deepspace
class PowerEfficientSpaceStation < SpaceStation
  
  def initialize(station)
    @@EFFICIENCYFACTOR = 1.1
    newCopy(station)
  end
  
  def fire
    return super*@@EFFICIENCYFACTOR
  end
  
  def protection
    return super*@@EFFICIENCYFACTOR
  end
  
  def setLoot(loot)
    super(loot)
    return Transformation::NOTRASNFORM
  end
 
end
end