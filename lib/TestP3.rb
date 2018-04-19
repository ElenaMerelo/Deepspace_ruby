# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

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
require_relative 'GameUniverse'

require 'pp'

module TestP3
	class P3
		def self.main_spacestation
			
			#spacestation
			sp1 = Deepspace::SuppliesPackage.new(1,1,1)	
			station1 = Deepspace::SpaceStation.new("station1",sp1)
			station1.receiveHangar(Deepspace::Hangar.new(20))
			
			#prueba de fire, añadir y quitar armas, modificar usos
			station1.receiveWeapon(Deepspace::Weapon.new("arma", Deepspace::WeaponType::MISSILE, 10))
			station1.mountWeapon(0)
			station1.receiveWeapon(Deepspace::Weapon.new("arma", Deepspace::WeaponType::PLASMA, 0))
			station1.mountWeapon(0)
      #pp station1
			#puts station1.fire()
			
			#prueba de protection
			station1.receiveShieldBooster(Deepspace::ShieldBooster.new("escudo", 3, 10))
      #pp station1
			station1.mountShieldBooster(0)
			station1.receiveShieldBooster(Deepspace::ShieldBooster.new("escudo", 4, 10))
			station1.mountShieldBooster(0)
      #pp station1
			#puts station1.protection()
			
			#prueba de receiveShot (<=12 resist; >12 donotresist)
			#puts station1.receiveShot(9)
			#puts station1.shieldPower
			
			station1.discardShieldBooster(0)
			station1.discardShieldBooster(0)
			station1.discardWeapon(0)
			station1.discardWeapon(0)
			station1.discardHangar
			#pp station1
			#puts "____"
			station1.setLoot(Deepspace::Loot.new(1, 1, 1, 1, 3))
			#pp station1
			
			#prueba discard para el damage numerico
			station2 = Deepspace::SpaceStation.new("station2",sp1)
			station2.receiveHangar(Deepspace::Hangar.new(20))
			station2.receiveWeapon(Deepspace::Weapon.new("arma", Deepspace::WeaponType::MISSILE, 10))
			station2.mountWeapon(0)
			station2.receiveShieldBooster(Deepspace::ShieldBooster.new("escudo", 4, 10))
			station2.mountShieldBooster(0)
			d1 = Deepspace::Damage.newNumericWeapons(2,3)
      #pp d1
			
			station2.setPendingDamage(d1)
			pp station2.pendingDamage
			station2.discardWeapon(0)
			pp station2.pendingDamage
			station2.discardShieldBooster(0)
			pp station2.pendingDamage
			
			#prueba discard damage específico
			station2.receiveWeapon(Deepspace::Weapon.new("arma", Deepspace::WeaponType::MISSILE, 10))
			station2.mountWeapon(0)
      pp station2
			station2.receiveWeapon(Deepspace::Weapon.new("arma", Deepspace::WeaponType::LASER, 10))
			station2.mountWeapon(0)
			d2 = Deepspace::Damage.newSpecificWeapons([Deepspace::WeaponType::LASER, Deepspace::WeaponType::MISSILE],1)

			station2.setPendingDamage(d2)
			pp station2.pendingDamage
			station2.discardWeapon(0)
			pp station2.pendingDamage
			
		end
		
		def self.main_gameuniverse
			universe1 = Deepspace::GameUniverse.new

			universe1.init(["a", "b"])
			
			pp universe1
			puts "============="
			
			puts universe1.combat()
			pp universe1
			puts "============="
			
			puts universe1.nextTurn
			pp universe1
			
		end
		
		
	end
	
	P3.main_spacestation
	#P3.main_gameuniverse
    
end
