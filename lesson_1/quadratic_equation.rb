print "Enter quadratic equation coefficients a, b and c:"
coefs = gets.chomp.split()
until coefs.length == 3
	print "Enter quadratic equation coefficients a, b and c:"
	coefs = gets.chomp.split()
end
coefs = coefs.map(&:to_i)
if coefs[0] == 0
	puts "It's not a quadratic equation!"
	return 
end
d = coefs[1]**2 - 4 * coefs[0] * coefs[2]
puts "#{d}"
if d > 0
	x1 = (-1 * coefs[1] - Math.sqrt(d)) / (2 * coefs[0])
	x2 = (-1 * coefs[1] + Math.sqrt(d)) / (2 * coefs[0])
	puts "Discriminant D = #{d}. Quadratic equation roots x1 = #{x1} and x2 = #{x2}."
elsif d == 0
	x = -1 * coefs[1] / (2 * coefs[0])
	puts "Discriminant D = #{d}. Quadratic equation root is x = #{x}."
else
	puts "Discriminant D = #{d}. Quadratic equation has no roots."
end