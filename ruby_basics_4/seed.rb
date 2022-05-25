# frozen_string_literal: true


require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'passenger_train'

s_f = Station.new('first')
s_s = Station.new('second')
s_th = Station.new('third')
r = Route.new('1', s_f, s_th)
r.add_intermediate_station(s_s)
puts r.inspect
w1 = Wagon.new('234', 'passenger')
w2 = Wagon.new('237', 'cargo')
w3 = Wagon.new('456', 'passenger')
w4 = Wagon.new('789', 'cargo')
w5 = Wagon.new('450', 'passenger')
w6 = Wagon.new('781', 'cargo')
train_pass = PassengerTrain.new('10045')
train_pass.attach_wagon(w1)
train_pass.attach_wagon(w3)
train_pass.attach_wagon(w5)
train_cargo = CargoTrain.new('10099')
train_cargo.attach_wagon(w2)
train_cargo.attach_wagon(w4)
train_cargo.attach_wagon(w6)
puts train_cargo.inspect
puts train_pass.inspect

