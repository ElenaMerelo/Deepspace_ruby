#encoding:utf-8
require_relative 'SpaceStation'
#require_relative 'Weapon'
require_relative 'WeaponType'
require_relative 'SuppliesPackage'
require_relative 'Loot'
require_relative 'EnemyStarShip'
require_relative 'Damage'
require_relative 'Dice'
require_relative 'GameUniverse'
require_relative 'SpaceStationToUI'
require 'pp'

module ExamenP3
  
class Test3
  def self.examen3
    s1 = Deepspace::SuppliesPackage.new(5,5,5)
    pp s1
    station1 = Deepspace::SpaceStation.new("estacion1",s1)
    
    pp station1
    
    puts "Imprimimos la nave con ayuda de SpaceStationToUI\n"
    
    spaceUI = Deepspace::SpaceStationToUI.new(station1)
    puts "#{spaceUI}"
    
    
    dice = Deepspace::Dice.new
    contador = [0,0,0]
    for i in 0...1000
      indice = dice.initWithNWeapons - 1
      contador[indice] += 1
    end
    
    pp contador 

    
    #Creamos un loot y un damage para crear la nave enemiga
    l1 = Deepspace::Loot.new(3,3,3,3,3)
    d1 = Deepspace::Damage.newSpecificWeapons([Deepspace::WeaponType::PLASMA, Deepspace::WeaponType::MISSILE, Deepspace::WeaponType::LASER, Deepspace::WeaponType::PLASMA],2)
    pp d1
    enemy1 = Deepspace::EnemyStarShip.new("enemigo1", 1,1,l1,d1)
    pp enemy1
    
    #Le añadimos un tesoro
    station1.setLoot(l1)
    
    #Montamos las armas y escudos, mientras haya hueco en el hangar
    for i in 0 ... station1.hangar.weapons.length
      station1.mountWeapon(0)
    end
    
    for i in 0 ... station1.hangar.shieldBoosters.length
      station1.mountShieldBooster(0)
    end
    
    #Mostramos cómo está la nave ahora
    
    pp station1
    
    #Ahora las naves combaten entre ellas
    
    universo = Deepspace::GameUniverse.new
    pp universo.combatGo(station1, enemy1)
   
    pp station1
    pp station1.validState
     
    
  end
end

Test3.examen3
end
