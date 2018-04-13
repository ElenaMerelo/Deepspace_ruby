#encoding:utf-8

require_relative 'SpaceStationToUI'
require_relative 'ShotResult'

module Deepspace

class SpaceStation
  @@MAXFUEL=100
  @@SHIELDLOSSPERUNITSHOT=0.1

  attr_reader :ammoPower, :fuelUnits, :name, :nMedals, :shieldPower, :hangar, :weapons, :shieldBoosters, :pendingDamage

  def initialize(n,s)
    @name = n
    @ammoPower = s.ammoPower
    @fuelUnits = s.fuelUnits
    @shieldPower = s.shieldPower
    @hangar = nil
    @weapons = []
    @shieldBoosters = []
    @pendingDamage = nil
    @nMedals = 0
  end

  def getUIversion
    SpaceStationToUI.new(self)
  end

  def receiveWeapon(w)
    if @hangar != nil
      @hangar.addWeapon(w)
    end
  end

  def receiveShieldBooster(s)
    if @hangar != nil
        @hangar.addShieldBooster(s)
    end
  end

  def receiveHangar(h)
    if @hangar == nil
      @hangar = h
    end
  end

  def discardHangar
    @hangar = nil
  end

  def receiveSupplies(s)
    @ammoPower += s.ammoPower
    @shieldPower += s.shieldPower
    if @fuelUnits + s.fuelUnits <= @@MAXFUEL
        @fuelUnits += s.fuelUnits
    else
        @fuelUnits = @@MAXFUEL
    end
  end

  def setPendingDamage(d)
    @pendingDamage = d.adjust(@weapons, @shieldBoosters)
  end

  def mountWeapon(i)
    if @hangar != nil
      rm = @hangar.removeWeapon(i)
      if rm != nil
        @weapons.push(rm)
      end
    end
  end

  def mountShieldBooster(i)
    if @hangar != nil
      rm = @hangar.removeShieldBooster(i)
      if rm != nil
        @shieldBoosters.push(rm)
      end
    end

  end

  def discardWeaponInHangar(i)
    if @hangar != nil
      @hangar.removeWeapon(i)
    end
  end

  def discardShieldBoosterInHangar(i)
    if @hangar != nil
      @hangar.removeShieldBooster(i)
    end

  end

  def getSpeed
    return @fuelUnits.to_f / @@MAXFUEL
  end

  def move
    @fuelUnits -= getSpeed * @fuelUnits.to_f
  end

  def validState
    return @pendingDamage == nil || @pendingDamage.hasNoEffect
  end

  def cleanUpMountedItems
    #Guardamos los índices
    indices = []
    for i in 0...@weapons.length
      if @weapons[i].uses == 0
        indices.push(i)
      end
    end

    indices.sort.reverse

    for i in indices
      @weapons.delete_at(i)
    end

    indices = []

    for i in 0...@shieldBoosters.length
      if @shieldBoosters[i].uses == 0
        indices.push(i)
      end
    end

    indices.sort.reverse

    for i in indices
      @shieldBoosters.delete_at(i)
    end
  end

  #Para la siguiente práctica
    def fire
      size = @weapons.length
      factor = 1.to_f
      for i in 0...size
        factor *= @weapons[i].useIt
      end

      return @ammoPower*factor
    end

    def protection
      size = @shieldBoosters.length
      factor = 1.to_f
      for i in 0...size
        factor *= @shieldBoosters[i].useIt
      end
      return @shieldPower*factor
    end

    def receiveShot(shot)
      myProtection = protection
      if(myProtection >= shot)
        @shieldPower -= @@SHIELDLOSSPERUNITSHOOT * shot
        @shieldPower = [0.0,@shieldPower].max
        return ShotResult::RESIST
      else
        @shieldPower = 0.0
        return ShotResult::DONOTRESIST
      end
    end

    def setLoot(loot)
      dealer = CardDealer.instance
      h = loot.nHangars
      if h > 0
        hangar = dealer.nextHangar
        receiveHangar(hangar)
      end

      elements = loot.nSupplies
      for i in 1..elements
        sup = dealer.nextSuppliesPackage
        receiveSupplies(sup)
      end

      elements = loot.nWeapons
      for i in 1..elements
        weap = dealer.nextWeapon
        receiveWeapon(weap)
      end

      elements = loot.nShields
      for i in 1..elements
        sh = dealer.nextShieldBooster
        receiveShieldBooster(sh)
      end

      medals = loot.nMedals
      @nMedals += medals
    end


    def discardWeapon(i)
      size = @weapons.length
      if i >= 0 && i < size
        w = @weapons.delete_at(i)
        if @pendingDamage != nil
          @pendingDamage.discardWeapon(w)
          cleanPendingDamage
        end
      end
    end

    def discardShieldBooster(i)
       size = @shieldBoosters.length
      if i >= 0 && i < size
        s = @shieldBoosters.delete_at(i)
        if @pendingDamage != nil
          @pendingDamage.discardShieldBooster
          cleanPendingDamage
        end
      end

    end

  def to_s
     return "Name #{@name} AmmoPower: #{@ammoPower} FuelUnits: #{@fuelUnits}
     ShieldPower: #{@shieldPower} Medals: #{@nMedals} Weapons: #{@weapons}
     ShieldBoosters: #{@shieldBoosters} Hangar: #{@hangar} PendingDamage: #{@pendingDamage}"
   end

  private
    def assignFuelValue(f)
      if f <= @@MAXFUEL
        @fuelsUnits = f
      end
    end

    def cleanPendingDamage
      if @pendingDamage.hasNoEffect
        @pendingDamage = nil
      end
    end


end
end
