days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def is_leap_year?(year)
  return (year % 4 == 0 and (year % 100 != 0 or year % 400 == 0))
end

puts "Enter 3 numbers: day month year:"
date = gets.chomp.split().map(&:to_i)
day = (is_leap_year?(date[2]) and (date[1] > 2)) ? date[0] + days_in_month[...date[1]-1].sum + 1 : date[0] + days_in_month[...date[1]-1].sum
puts "You picked #{day}th day in that year"

