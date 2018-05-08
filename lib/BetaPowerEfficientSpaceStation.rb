# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'PowerEfficientSpaceStation'
require_relative 'Dice'

module Deepspace

class BetaPowerEfficientSpaceStation < PowerEfficientSpaceStation
  @@EXTRAEFFICIENCY = 1.2
  def initialize(station)
    super(station)   
    @dice = Dice.new
  end
  
  def fire 
    if(@dice.extraEfficiency)
      return super*@@EXTRAEFFICIENCY
    else
      return super
    end
  end
  
  
end

end