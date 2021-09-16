print "Enter your name:"
user_name = gets.chomp
print "Enter your height in cm:"
user_height = gets.chomp.to_i


perfect_weight = (user_height - 110) * 1.15
if perfect_weight > 0
	puts"#{user_name}, your perfect weight is #{perfect_weight.round(1)} kg."
else
	puts "Your weight is already optimal!"
end