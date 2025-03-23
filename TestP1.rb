#encoding:utf-8
require_relative 'Monster'
require_relative 'Dice'
require_relative 'Shield'

module Irrgarten
  monstruo = Monster.new("Dinga",Dice.random_intelligence(),Dice.random_strength())
  puts(monstruo.to_s)
end