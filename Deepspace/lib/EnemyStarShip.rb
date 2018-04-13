#encoding:utf-8
require_relative 'EnemyToUI'
module Deepspace
class EnemyStarShip
  
  attr_reader :ammoPower, :name, :shieldPower, :loot, :damage
  
  def initialize(n,a,s,l,d)
    @ammoPower = a
    @name = n
    @shieldPower = s
    @loot = l
    @damage = Damage.newCopy(d)
  end
  
  def self.newCopy(copy)
    EnemyStarShip.new(copy.name, copy.ammoPower, copy.shieldPower, copy.loot, copy.damage)
  end
  
  def getUIversion()
    EnemyToUI.new(self)
  end
  
  def protection
    @shieldPower
  end
  
  def fire
    @ammoPower
  end
  
  def receiveShot(shot)
    if shot > @shieldPower
      return ShotResult::DONOTRESIST
    else
      return ShotResult::RESIST
    end
  end
  
  def to_s
      return "\nName: #{@name} AmmoPower: #{@ammoPower} ShieldPower: #{@shieldPower} Loot:#{@loot} Damage:#{@damage}"
  end
  
  
end
end
