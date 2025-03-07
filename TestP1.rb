#encoding:utf-8
require_relative 'Weapon'
require_relative 'Dice'
require_relative 'Shield'

module Irrgarten
  arma = Weapon.new(Dice.weapon_power(),Dice.uses_left())
  escudo = Irrgarten::Shield.new(Dice.shield_power(),Dice.uses_left())

  puts(arma.to_s)
  puts(escudo.to_s)

  puts("Me descarto: " + arma.discard().to_s)
  puts("Me descarto: " + escudo.discard().to_s)
end