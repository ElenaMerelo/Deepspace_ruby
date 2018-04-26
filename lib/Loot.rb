#encoding:utf-8
require_relative 'LootToUI'
module Deepspace
class Loot
  attr_reader :nSupplies, :nWeapons, :nShields, :nHangars, :nMedals, :spaceCity, :efficient
  
  def initialize(nSupplies, nWeapons, nShields, nHangars,nMedals, ef, city)
    @nSupplies = nSupplies
    @nWeapons = nWeapons
    @nShields = nShields
    @nHangars = nHangars
    @nMedals = nMedals   
    @spaceCity = city
    @efficient = ef
  end
  
  def self.newL(nSupplies, nWeapons, nShields, nHangars,nMedals)
    new(nSupplies, nWeapons, nShields, nHangars,nMedals, false, false)
  end
  
   def to_s
    "\nSupplies: #{@nSupplies}, nWeapons: #{@nWeapons} , nShields: #{@nShields}" +
      "nHangars: #{@nHangars}, nMedals: #{@nMedals}"
  end
  
   def getUIversion
     LootToUI.new(self)
   end
   
   def to_s
       return "\nnSupplies = #{@nSupplies} nWeapons = #{@nWeapons} nShields = #{@nShields} nHangars = #{@nHangars} Medals = #{@nMedals}"
  end 
  
end
end
