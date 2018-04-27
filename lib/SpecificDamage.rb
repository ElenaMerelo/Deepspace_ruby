# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "Damage"
require_relative "SpecificDamageToUI"
module Deepspace
class SpecificDamage < Damage
  public_class_method :new
  attr_reader :weapons
  
  def initialize(weapons, nShields)
    @weapons = weapons
    super(nShields)
  end
  
  def adjust(w,s)
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
      SpecificDamage.new(aux, [@nShields,s.length].min) 
  end
  
  def discardWeapon(w)
    i = @weapons.index(w.type)
    if i != nil
      @weapons.delete_at(i)
    end
  end
  
  
  def to_s
      super + "\nweapons: #{@weapons}"
  end
  
end
end
