puts "Enter the side A of the triangle (sm):"
a_side = gets.chomp.to_f
puts "Enter the side B of the triangle (sm):"
b_side = gets.chomp.to_f
puts "Enter the side C of the triangle (sm):"
c_side = gets.chomp.to_f

type_tri = []
tri = [a_side, b_side, c_side].sort
type_tri.push('equilateral') if tri[0] == tri[1] && tri[0] == tri[2] && tri[1] == tri[2]
type_tri.push('isosceles') if tri[0] == tri[1] || tri[0] == tri[2] || tri[1] == tri[2]
type_tri.push('right') if ((tri[0] ** 2 + tri[1] ** 2) - (tri[2] ** 2)).abs < 0.001
puts type_tri.any? ? "The triangle is: #{type_tri.join(', ')}." : "Triangle is regular."
