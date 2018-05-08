# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "Damage"
require_relative "NumericDamageToUI"

module Deepspace

class NumericDamage < Damage
  public_class_method :new
  
  attr_reader :nWeapons
  
  def initialize(nweapons, nshields)
    super(nshields)
    @nWeapons = nweapons
  end
 
  def getUIversion()
    NumericDamageToUI.new(self)
  end
  
  def adjust(w,s)
    NumericDamage.new([@nWeapons,w.length].min, super)
  end
  
  def discardWeapon(w)
    @nWeapons -= 1
  end
  
  def copy
    NumericDamage.new(@nWeapons,@nShields)
  end
  
  def hasNoEffect
    @nWeapons == 0 && super
  end
  
  def to_s
    return super + "\nnWeapons: #{@nWeapons}"
  end
  
end

end
