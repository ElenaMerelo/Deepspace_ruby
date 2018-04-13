#encoding:utf-8
require_relative 'LootToUI'
module Deepspace
class Loot
  attr_reader :nSupplies, :nWeapons, :nShields, :nHangars, :nMedals 
  
  def initialize(nSupplies, nWeapons, nShields, nHangars,nMedals)
    @nSupplies = nSupplies
    @nWeapons = nWeapons
    @nShields = nShields
    @nHangars = nHangars
    @nMedals = nMedals    
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
