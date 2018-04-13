#encoding:utf-8
module Deepspace
module WeaponType
    class Type
      attr_reader :power, :name
      
      def initialize(pow, s)
        @power = pow
        @name = s
      end
      
      def to_s
        "#{@name}, Power #{@power}"
      end
      
    end
    
    LASER = Type.new(2.0, "LASER")
    MISSILE = Type.new(3.0, "MISSILE")
    PLASMA = Type.new(4.0, "PLASMA")
    
    
end
end