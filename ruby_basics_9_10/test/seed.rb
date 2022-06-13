# frozen_string_literal: true

Dir['../models/*.rb'].sort!.each { |file| require_relative file }

s_f = Station.new('first')
s_s = Station.new('second')
s_th = Station.new('third')
s_fth = Station.new('fourth')
s_ff = Station.new('fifth')
s_sx = Station.new('sixth')

s_f.valid?

s_f.traffic = 234_000
s_f.traffic = 256_000
s_f.temperature = 25
s_f.temperature = 28
s_f.owner = 'Mr Gilmor'
puts s_f.instance_variables.inspect
puts s_f.traffic
puts s_f.temperature_history
puts s_f.owner

r = Route.new('1A', s_f, s_sx)
r.add_intermediate_station(s_s)
r.delete_intermediate_station(s_s)
r.add_intermediate_station(s_s)
r.add_intermediate_station(s_th)
r.add_intermediate_station(s_fth)
r.add_intermediate_station(s_ff)
w0 = CargoBigWagon.new('456789GF', 44)
w1 = PassengerWagon.new('234456SD', 20)
w2 = CargoWagon.new('234456SG', 80)

# puts w1.occupy
# puts w2.occupy(45)

w3 = PassengerWagon.new('234456SK', 33)
w4 = CargoWagon.new('234456SL', 85)
w5 = PassengerWagon.new('234456SS', 25)
w6 = CargoWagon.new('234456QD', 100)
w6.manufacturing_company_name = 'Baumgaumner'
train_pass = PassengerTrain.new('100-45')
train_pass.attach_wagon(w1)
train_pass.attach_wagon(w3)
train_pass.attach_wagon(w5)
train_cargo = CargoTrain.new('10099')
train_cargo.attach_wagon(w0)
train_cargo.attach_wagon(w2)
train_cargo.attach_wagon(w4)
train_cargo.attach_wagon(w6)
train_cargo.manufacturing_company_name = 'CluadoSSF'

train_pass.take_route(r)
train_cargo.take_route(r)

# puts r.inspect
# puts train_cargo.inspect
# puts train_pass.inspect
# puts train_cargo.manufacturing_company_name
# puts Station.all
# puts Train.all
# puts Route.all
# puts Station.instances
# puts Train.instances
# puts PassengerTrain.instances
# puts CargoTrain.instances
# puts Route.instances

Station.instances.each do |station|
  puts "Station: #{station.name} #{station.trains.size} trains:"
  station.each_train do |train|
    puts "#{train.number} #{train.type} #{train.wagons.size} wagons:"
    train.each_wagon do |wagon|
      puts "#{wagon.number} #{wagon.type} #{wagon.free} #{wagon.occupied}"
    end
  end
end
