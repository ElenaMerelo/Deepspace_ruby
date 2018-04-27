#encoding:utf-8
require_relative 'DamageToUI'
require 'pp'

module Deepspace

class Damage
  attr_reader :nShields
  
  def initialize(nshields)
    @nShields=nshields
  end
  
  def copy
    return "This isnt implemented yet"
  end
  
 def getUIversion
   DamageToUI.new(self)
 end
  
  def discardShieldBooster
    if @nShields > 0
      @nShields -= 1
    end
  end
 
=begin
 def arrayContainsType(w,s)
    for i in 0...w.length
      if w[i].type == s
        return i
      end
    end
    return -1
 end
=end 
  def to_s
      return "\nnShields: #{@nShields}"
  end

 #private_class_method :new
  
end

end
