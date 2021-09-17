def triangle_is_right(sides)
	sides = sides.sort
	hypotenuse = sides[2]
	if hypotenuse**2 == sides[0]**2 + sides[1]**2
		return true
	else
		return false
	end
end

print "Enter 3 sides of a triangle:"
sides = gets.chomp.split()
until sides.length == 3
	print "Enter 3 sides of a triangle:"
	sides = gets.chomp.split()
end
sides = sides.map(&:to_i)
if sides.uniq.length == 1
	puts "The triangle is equilateral! (and isosceles by default)"
elsif sides.uniq.length == 2
	if triangle_is_right(sides)
		puts "The triangle is isosceles and right!"
	else
		puts "The triangle is isosceles!"
	end
elsif triangle_is_right(sides)
	puts "The triangle is right!"
else
	puts "That's just an ordinary triangle"
end
	