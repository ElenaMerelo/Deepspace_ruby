#encoding:utf-8
require_relative 'HangarToUI'

module Deepspace

class Hangar

  attr_reader :maxElements, :weapons, :shieldBoosters

  def initialize(capacity)
    @maxElements = capacity
    @weapons = Array.new
    @shieldBoosters = Array.new
  end

  def self.newCopy(copy)
    nuevo = new(copy.maxElements)
    for i in 0...copy.weapons.length
      nuevo.addWeapon(copy.weapons[i])  
    end
    
    copy.shieldBoosters.each{|elem|
      nuevo.addShieldBooster(elem)
    }   
    
    return nuevo    
  end

  def getUIversion
    HangarToUI.new(self)
  end

  def addWeapon(w)
    if spaceAvailable
      @weapons.push(w)
    end
    spaceAvailable
  end

  def addShieldBooster(s)
    if spaceAvailable
      @shieldBoosters.push(s)
    end
    spaceAvailable
  end

  def removeWeapon(w)
    if w >= 0 && w < @weapons.length
      return @weapons.delete_at(w)
    else
      return nil
    end      
  end

   def removeShieldBooster(s)
     if s >=0 && s < @shieldBoosters.length
      return @shieldBoosters.delete_at(s)   
     else
       return nil
     end
  end

  def to_s
      return "MaxElements: #{@maxElements} Weapons: #{@weapons.join(", ")} ShieldBoosters: #{@shieldBoosters.join(", ")}"
  end

  private
  def spaceAvailable
    return @weapons.length + @shieldBoosters.length < @maxElements
  end


end

end
