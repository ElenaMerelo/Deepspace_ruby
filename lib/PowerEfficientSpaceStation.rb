# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "Transformation"
require_relative "SpaceStation"

module Deepspace
class PowerEfficientSpaceStation < SpaceStation
  
  def initialize(s)
    @@EFFICIENCYFACTOR = 1.1
    super(s.name, s.ammoPower, s.fuelUnits, s.shieldPower, s.hangar, s.weapons,s.shieldBoosters, \
    s.pendingDamage,s.nMedals)
  end
  
  def fire
    return super*@@EFFICIENCYFACTOR
  end
  
  def protection
    return super*@@EFFICIENCYFACTOR
  end
  
  def setLoot(loot)
    super(loot)
    return Transformation::NOTRANSFORM
  end
 
end
end