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
sides = sides.map(&:to_i)
unless sides.length == 3
	print "Enter 3 sides of a triangle:"
	sides = gets.chomp.split()
end
if (sides[0] == sides[1]) and (sides[1] == sides[2])
	puts "The triangle is equilateral! (and isosceles by default)"
elsif (sides[0] == sides[1] and sides[0] != sides[2]) or (sides[0] == sides[2] and sides[0] != sides[1]) or (sides[1] == sides[2] and sides[0] != sides[1])
	if triangle_is_right(sides)
		puts "The triangle is isosceles and right!"
	else
		puts "The triangle is isosceles!"
	end
elsif triangle_is_right(sides)
	puts "The triangle is right!"
else
	puts "That's just and ordinary triangle"
end
	