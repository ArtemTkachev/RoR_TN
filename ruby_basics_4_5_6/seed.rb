# frozen_string_literal: true

require_relative './models/route'
require_relative './models/train'
require_relative './models/station'
require_relative './models/wagon'
require_relative './models/cargo_train'
require_relative './models/passenger_train'

s_f = Station.new('first')
s_s = Station.new('second')
s_th = Station.new('third')
s_fth = Station.new('fourth')
s_ff = Station.new('fifth')
s_sx = Station.new('sixth')

r = Route.new('1A', s_f, s_sx)
r.add_intermediate_station(s_s)
r.delete_intermediate_station(s_s)
r.add_intermediate_station(s_s)
r.add_intermediate_station(s_th)
r.add_intermediate_station(s_fth)
r.add_intermediate_station(s_ff)
w1 = Wagon.new('234456SD', 'passenger')
w2 = Wagon.new('234456SD', 'cargo')
w3 = Wagon.new('234456SD', 'passenger')
w4 = Wagon.new('234456SD', 'cargo')
w5 = Wagon.new('234456SD', 'passenger')
w6 = Wagon.new('234456SD', 'cargo')
w6.manufacturing_company_name = 'Baumgaumner'
train_pass = PassengerTrain.new('100-45')
train_pass.attach_wagon(w1)
train_pass.attach_wagon(w3)
train_pass.attach_wagon(w5)
train_cargo = CargoTrain.new('10099')
train_cargo.attach_wagon(w2)
train_cargo.attach_wagon(w4)
train_cargo.attach_wagon(w6)
train_cargo.manufacturing_company_name = 'CluadoSSF'
puts r.inspect
puts train_cargo.inspect
puts train_pass.inspect
puts train_cargo.manufacturing_company_name
puts Station.all
puts Train.all
puts Route.all
puts Station.instances
puts Train.instances
puts PassengerTrain.instances
puts CargoTrain.instances
puts Route.instances
