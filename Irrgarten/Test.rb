#encoding:utf-8
require_relative '../TextUI/textUI'
require_relative '../Controller/controller'
require_relative 'Game'

module Irrgarten
  partida = Game.new(1)
  controller = Control::Controller.new(partida,UI::TextUI.new)
  controller.play()
end