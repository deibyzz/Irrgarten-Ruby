#encoding:utf-8
require_relative 'Weapon'
require_relative 'Dice'
require_relative 'Shield'

module Irrgarten
  arma = Weapon.new(Dice.weapon_power,Dice.uses_left)
  discard = false
  contador = 0
  for i in (0..99)
    discard = arma.discard
    puts(discard)
    if(discard)
      contador +=1
    end
  end
  puts(arma.to_s)
  puts(contador)
end