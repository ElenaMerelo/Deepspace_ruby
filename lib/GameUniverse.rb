#encoding:utf-8
require_relative 'Dice'
require_relative 'GameUniverseToUI'
require_relative 'GameStateController'
require_relative 'SpaceStation'
require_relative 'CombatResult'
require_relative 'CardDealer'

module Deepspace
class GameUniverse

  @@WIN = 10


  def initialize
    @turns = 0
    @currentStationIndex = 0
    @dice = Dice.new
    @gameState = GameStateController.new
    @currentEnemy =  nil
    @spaceStations = []
    @currentStation = nil
    @haveSpaceCity = false
  end
  
  def state
     return @gameState.state
  end

  def haveAWinner
    @currentStation.nMedals >= @@WIN
  end

  def getUIversion
    GameUniverseToUI.new(@currentStation, @currentEnemy)
  end

  def discardHangar
    if @gameState.state == GameState::INIT || @gameState.state == GameState::AFTERCOMBAT
      @currentStation.discardHangar
    end
  end

  def discardShieldBooster(i)
    if @gameState.state == GameState::INIT || @gameState.state == GameState::AFTERCOMBAT
      @currentStation.discardShieldBooster(i)
    end
  end

  def discardShieldBoosterInHangar(i)
    if @gameState.state == GameState::INIT || @gameState.state == GameState::AFTERCOMBAT
      @currentStation.discardShieldBoosterInHangar(i)
    end
  end

  def discardWeapon(i)
    if @gameState.state == GameState::INIT || @gameState.state == GameState::AFTERCOMBAT
      @currentStation.discardWeapon(i)
    end
  end

  def discardWeaponInHangar(i)
    if @gameState.state == GameState::INIT || @gameState.state == GameState::AFTERCOMBAT
      @currentStation.discardWeaponInHangar(i)
    end
  end

  def mountShieldBooster(i)
    if @gameState.state == GameState::INIT || @gameState.state == GameState::AFTERCOMBAT
      @currentStation.mountShieldBooster(i)
    end
  end

  def mountWeapon(i)
    if @gameState.state == GameState::INIT || @gameState.state == GameState::AFTERCOMBAT
      @currentStation.mountWeapon(i)
    end
  end

  #Proxima practica
    def init(names)
      if state == GameState::CANNOTPLAY
        dealer = CardDealer.instance

        for i in 1..names.length
          supplies = dealer.nextSuppliesPackage
          station = SpaceStation.new(names[i-1], supplies)
          nh = @dice.initWithNHangars
          nw = @dice.initWithNWeapons
          ns = @dice.initWithShields
          l = Loot.newL(0, nw, ns, nh, 0)
          station.setLoot(l)
          @spaceStations.push(station)
        end

        @currentStationIndex = @dice.whoStarts(names.length)
        @currentStation = @spaceStations[@currentStationIndex]
        @currentEnemy = dealer.nextEnemy

        @gameState.next(@turns, @spaceStations.size)

        end
     end

    def nextTurn
      gameState = @gameState.state

      if gameState == GameState::AFTERCOMBAT
        stationState = @currentStation.validState
        if stationState
          @currentStationIndex = (@currentStationIndex+1) % @spaceStations.size
          @turns += 1

          @currentStation = @spaceStations[@currentStationIndex]
          @currentStation.cleanUpMountedItems
          dealer = CardDealer.instance
          @currentEnemy = dealer.nextEnemy
          @gameState.next(@turns, @spaceStations.size)

          return true
        end
        return false
      end
      return false
    end

    def combat
      if state == GameState::BEFORECOMBAT || state == GameState::INIT
        return combatGo(@currentStation, @currentEnemy)
      else
        return CombatResult::NOCOMBAT
      end
    end

  def combatGo(station, enemy)
      ch = @dice.firstShot
      if ch == GameCharacter::ENEMYSTARSHIP
        fire = enemy.fire
        result = station.receiveShot(fire)

        if result == ShotResult::RESIST
          fire = station.fire
          result = enemy.receiveShot(fire)
          enemyWins = (result == ShotResult::RESIST)
        else
          enemyWins = true
        end
      else
        fire = station.fire
        result = enemy.receiveShot(fire)
        enemyWins = (result == ShotResult::RESIST)
      end

      if enemyWins
        s = station.getSpeed
        moves = @dice.spaceStationMoves(s)
        if !moves
          damage = enemy.damage
          station.setPendingDamage(damage)
          combatResult = CombatResult::ENEMYWINS
        else
          station.move
          combatResult = CombatResult::STATIONESCAPES
        end
      else
        aLoot = enemy.loot
        r = station.setLoot(aLoot)
        if r == Transformation::GETEFFICIENT
          makeStationEfficient
        else if r == Transformation::SPACECITY
           createSpaceCity
        end
        end
        combatResult = CombatResult::STATIONWINS
      end

      @gameState.next(@turns, @spaceStations.size)

      return combatResult
  end
  
  def createSpaceCity
    if (!@haveSpaceCity)
      @currentStation = SpaceCity.new(@currentStation, @spaceStations)
    end
  end
  
  def makeStationEfficient
    if(@dice.extraEfficiency)
      @currentStation = BetaPowerEfficientSpaceStation.new(@currentStation)
    else
      @currentStation = PowerEfficientSpaceStation.new(@currentStation)
    end
  end
  
  
  
  def to_s
      return "\nIndex: #{@currentStationIndex} + Turns: #{@turns} + SpaceStations: #{@spaceStations} + CurrenStation: #{@currentStation} + CurrentEnemy: #{@currentEnemy}"
   end

end
end
