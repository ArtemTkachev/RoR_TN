# frozen_string_literal: true

# 1
months = { january: 31, february: 28, marth: 31,
           april: 30,   may: 31,      june: 30,
           july: 31,    august: 31,   september: 30,
           october: 31, novemner: 30, december: 31 }
months.each { |key, value| puts key if value == 30 }

# 2
numbers = []
(10..100).each { |num| numbers.push(num) if (num % 5).zero? }

# 3
fibo_numbers = [0, 1]
fibo_num = 0
loop do
  fibo_num = fibo_numbers.last + fibo_numbers[-2]
  break if fibo_num > 100

  fibo_numbers.push(fibo_num)
end

# fibo_numbers.push(fibo_numbers.last + fibo_numbers[-2]) while fibo_numbers.last + fibo_numbers[-2] < 100

# 4
vowels_hash = {}
vowels_arr = %w[a e i o u y]
indx = 1
('a'..'z').each do |letter|
  vowels_hash[letter] = indx if vowels_arr.include?(letter)
  indx += 1
end
