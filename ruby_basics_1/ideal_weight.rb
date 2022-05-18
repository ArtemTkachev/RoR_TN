puts "What's your name?"
name = gets.chomp
puts "What's your height (sm)?"
height = gets.chomp
weight = (height.to_i - 110) * 1.15
if weight >= 0
  puts "#{name}, your ideal weight is: #{weight} kg"
else
  puts "Your weight is already optimal!"
end
