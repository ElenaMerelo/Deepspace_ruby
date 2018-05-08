# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "SpaceStation"
require_relative "Transformation"

module Deepspace
class SpaceCity < SpaceStation
  attr_reader :collaborators
  
  def initialize(base, rest)
    @base = base
    @collaborators = rest
    super(base.name, base.ammoPower, base.fuelUnits, base.shieldPower, \
        base.hangar, base.weapons,base.shieldBoosters, base.pendingDamage,base.nMedals) 
  end
  
  def fire
    f = super
    for i in 0 ... @collaborators.length
      f += @collaborators[i].fire 
    end
    
    return f
  end
  
  def protection
    p = super
    for i in 0 ... @collaborators.length
      p += @collaborators[i].protection 
    end
    
    return p
  end
  
  def setLoot(loot)
    super(loot)
    return Transformation::NOTRANSFORM
  end
  
end
end