#encoding: utf-8
require_relative "CombatResult"
require_relative "GameCharacter"
require_relative "Loot"
require_relative "ShieldBooster"
require_relative "ShotResult"
require_relative "SuppliesPackage"
require_relative "Weapon"
require_relative "WeaponType"
require_relative 'Dice'
require_relative 'Damage'
require_relative 'EnemyStarShip'
require_relative 'SpaceStation'
require_relative 'Hangar'
require 'pp'


module Testp2
  class P2
    def main
      #weapons
      w1 = Deepspace::Weapon.new("weapon", Deepspace::WeaponType::LASER, 0)
      w2 = Deepspace::Weapon.new("weapon2", Deepspace::WeaponType::MISSILE, 1)
      w3 = Deepspace::Weapon.new("weapon3", Deepspace::WeaponType::PLASMA, 3)
      w4 = Deepspace::Weapon.new("weapon4", Deepspace::WeaponType::LASER, 2)
      
      #shieldbooster
      s1 = Deepspace::ShieldBooster.new("shield1", 5, 6)
      s2 = Deepspace::ShieldBooster.new("shield2", 3, 0) 
      
      d1 = Deepspace::Damage.newNumericWeapons(2,3)
      ws2 = Array.new
      ws2.push(Deepspace::WeaponType::LASER)
      ws2.push(Deepspace::WeaponType::LASER)

      d2 = Deepspace::Damage.newSpecificWeapons(ws2, 1)
       
      ws1 = Array.new
      ws1.push(w1)
      ws1.push(w2)
      ws1.push(w3)
      ws1.push(w4)
      
      ss1= Array.new
      ss1.push(s1)
      ss1.push(s1)
      
      pp ws1
      pp ss1
      
      puts "Prueba del adjust numérico: debería salir 2 y 2"
      adj1 = d1.adjust(ws1, ss1)
      pp adj1
      
      puts "Prueba del adjust específico, debería sacar dos lásers"
      adj2 = d2.adjust(ws1, ss1)
      pp adj2
      pp adj2.weapons
      
      puts "Prueba descarte de armas, debería salir un vector vacío"
      adj2.discardWeapon(w1)      
      pp adj2
      
     puts "Prueba hasnoeffect, debe dar false: #{adj2.hasNoEffect}"
   
     #Pruebas para ver que no se quitan cosas de más ni falla
     adj2.discardShieldBooster
     adj2.discardShieldBooster
     adj2.discardWeapon(w1)
     pp adj2
     puts "Prueba2 hasnoeffect, debe dar true: #{adj2.hasNoEffect}"
      
    adj1.discardWeapon(w1)
    puts "nWeapons debe salir 1:"
    pp adj1
    
    
    
    #Probamos la clase enemystarship
    puts "\n\nProbamos la clase enemystarship"
    e1 = Deepspace::EnemyStarShip.new(5,"Flota imperial",4, Deepspace::Loot.new(1,2,3,4,5), d1)
    e2 = Deepspace::EnemyStarShip.new(5,"Enemigo",1, Deepspace::Loot.new(1,2,3,4,5), d2)
    puts "#{e1} #{e2}"
    
    puts "ReceiveShot(debe salir resits:  #{e1.receiveShot(2)}"
   
      
    puts "\n\nProbamos hangar"
    h1 = Deepspace::Hangar.new(3)
    pp h1
    
    h1.addWeapon(w1)
    pp h1
    h1.addShieldBooster(s1)
    h1.addShieldBooster(s2)
    h1.addWeapon(w2)

    pp h1
    
    puts "Remove arma1 y escudo1"
    h1.removeWeapon(0)
    h1.removeShieldBooster(0)
    pp h1 
   
    puts "\n\nProbamos la clase SpaceStation"
    p1 = Deepspace::SuppliesPackage.new(1.1,2.2,3.3)
    station1 = Deepspace::SpaceStation.new("Alianza rebelde", p1)
    pp station1
    
    station1.receiveWeapon(w1)
    puts "\nDebe salir igual que antes"
    pp station1
    
    station1.receiveHangar(h1)
    puts "\nRecibe hangar1"
    pp station1
    
    station1.receiveWeapon(w1)
    pp station1

    station1.receiveShieldBooster(s1)
    station1.receiveShieldBooster(s1)
    pp station1
    
    station1.setPendingDamage(d1)
    pp station1

    puts "\n\nProbando receiveSupplies"
    station1.receiveSupplies(p1)
    pp station1

    station1.mountWeapon(0)
    station1.mountShieldBooster(0)
    pp station1
  
    puts "\ngetSpeed"
    pp station1.getSpeed
    
    puts "\nmove"
    pp station1.move
    pp station1
=begin
    puts "\nDiscard in hangar"
    h1.addWeapon(w2)
    station1.discardWeaponInHangar(0)
    pp station1
    
    puts "\nClean mounted items"
    station1.mountShieldBooster(0)
    station1.cleanUpMountedItems
    pp station1
    
   puts "Valid state: #{station1.validState}"
=end

   puts "\nCopias: "
   pp d2
   pp Deepspace::Damage.newCopy(d2)
   
   pp e2
   pp Deepspace::EnemyStarShip.newCopy(e2)
   
   pp w2
   pp Deepspace::Weapon.newCopy(w2)
   
   pp s1
   pp Deepspace::ShieldBooster.newCopy(s1)
   
   puts "\nCopia hangar:"
   pp h1
   pp Deepspace::Hangar.newCopy(h1)
   
    pp w1.type
   
   
   
     
    
    end
  end
  
  p = P2.new
  p.main
end
