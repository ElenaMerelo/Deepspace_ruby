#encoding:utf-8
require_relative 'DamageToUI'
require 'pp'

module Deepspace

class Damage
  attr_reader :nShields, :nWeapons, :weapons
  
  def initialize(nweapons, nshields,weapons)
    @nShields=nshields
    @nWeapons=nweapons
    if(weapons != nil)
      @weapons = Array.new(weapons)
    else
      @weapons = nil
    end
  end

  def self.newNumericWeapons(w, s)
    new(w,s,nil)
  end
  
  def self.newSpecificWeapons(wl,s)
    new(-1,s,wl)
  end
  
  def self.newCopy(copy)
    new(copy.nWeapons, copy.nShields, copy.weapons)
  end
  
  def getUIversion
    DamageToUI.new(self)
  end
  
  def adjust(w,s)
    # Primero miramos si es numérico o armas concretas el arma
    if @nWeapons == -1 #Entonces es específico
      weaponTypes = []
      w.each{|elem|
        weaponTypes.push(elem.type)
      }   
      #Calculamos la intersección entre weaponTypes & @weapons
      aux = weaponTypes & @weapons
      for i in 0...aux.length
        k = [weaponTypes.count(aux[i]), @weapons.count(aux[i])].min
        for j in 2..k
          aux.push(aux[i])
        end
      end
      Damage.newSpecificWeapons(aux, [@nShields,s.length].min)      
    else #Entonces es numérico
      Damage.newNumericWeapons([@nWeapons,w.length].min, [@nShields,s.length].min)      
    end    
  end
    
  def discardWeapon(w)
    if @nWeapons == -1 #Entonces es específico
      i = @weapons.index(w.type)
      if i != nil
        @weapons.delete_at(i)
      end
    else
      if @nWeapons > 0 
        @nWeapons -= 1
      end
    end     
  end
  
  def discardShieldBooster
    if @nShields > 0
      @nShields -= 1
    end
  end
  
  
  def hasNoEffect
    return @nShields == 0 && (@nWeapons == 0 || @weapons.length == 0)
  end 
  
 def arrayContainsType(w,s)
    for i in 0...w.length
      if w[i].type == s
        return i
      end
    end
    return -1
 end
  
  def to_s
    if nWeapons == -1
      return "\nnShields: #{@nShields} weapons: #{@weapons}"
    end
    return "\nnShields: #{@nShields} nWeapons: #{@nWeapons}"
  end

  private :arrayContainsType
  private_class_method :new
  
end

end