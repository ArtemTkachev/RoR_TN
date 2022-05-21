# frozen_string_literal: true

months = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30,
           7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31 }

day = 0, month = 0, year = 0
loop do
  puts 'Enter the day of the month:'
  day = gets.chomp.to_i
  puts 'Enter the month number:'
  month = gets.chomp.to_i
  puts 'Enter the year:'
  year = gets.chomp.to_i
  unless month.between?(1, 12) && day.between?(1, months[month])
    puts 'The entered data is not correct!'
    next
  end
  break
end

months[2] = 29 if (year % 4).zero? && (((year % 100).zero? && (year % 400).zero?) || !(year % 100).zero?)

day_num = 0
months.each do |month_num, sum_days|
  day_num += day if month_num == month
  day_num += sum_days if month_num < month
end

puts "The serial number of the day in the year: #{day_num}"
