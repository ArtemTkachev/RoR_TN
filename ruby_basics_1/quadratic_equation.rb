puts "Enter A coefficient:"
a_coef = gets.chomp.to_f
puts "Enter B coefficient:"
b_coef = gets.chomp.to_f
puts "Enter C coefficient:"
c_coef = gets.chomp.to_f

discr = b_coef ** 2 - 4 * a_coef * c_coef
if discr > 0
  x1 = (- b_coef + Math.sqrt(discr)) / (2 * a_coef)
  x2 = (- b_coef - Math.sqrt(discr)) / (2 * a_coef)
  puts "D = #{discr}, x1 = #{x1}, x2 = #{x2}"
elsif discr == 0
  x1 = - b_coef / (2 * a_coef)
  puts "D = #{discr}, x1 = x2 = #{x1}"
else
  puts "D = #{discr}, no roots"
end

