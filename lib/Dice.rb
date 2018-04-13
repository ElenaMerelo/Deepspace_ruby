#encoding:utf-8
require_relative "GameCharacter"

module Deepspace

class Dice   
  def initialize
    @generator = Random.new
    @NHANGARSPROB = 0.25
    @NSHIELDSPROB = 0.25
    @NWEAPONSPROB = 0.33
    @FIRSTSHOTPROB = 0.5
    
  end
  
  def initWithNHangars
    if @generator.rand(1.0) >= @NHANGARSPROB
      return 1
    else
      return 0
    end
  end
  
  def initWithNWeapons
    aux = @generator.rand(1.0)
    if aux < @NWEAPONSPROB
      return 1
    elsif aux < 2*@NWEAPONSPROB
      return 2
    else 
      return 3
    end
  end
  
  def initWithShields
    if @generator.rand(1.0) <= @NSHIELDSPROB
      return 0
    else
       return 1
    end
  end
  
  def whoStarts(nPlayers)
    return @generator.rand(nPlayers) #Con ... excluye el límite superior, con ..
    #lo incluye  
  end
  
  def firstShot
     if @generator.rand(1.0) <= @FIRSTSHOTPROB
      return GameCharacter::SPACESTATION
    else
       return GameCharacter::ENEMYSTARSHIP
    end
  end
  
  def spaceStationMoves(speed)
    @generator.rand(1.0) <= speed
  end
  
  def to_s
       return "\nNHANGARSPROB = #{@NHANGARSPROB} NSHIELDSPROB = #{@NSHIELDSPROB} NWEAPONSPROB = #{@NWEAPONSPROB} FIRSTSHOTPROB = #{@FIRSTSHOTPROB}"
end
end
end
