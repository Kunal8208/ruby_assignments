def school_level(grade)
	return "Elementary" if grade.between?(1,5)
	return "Middle School" if grade.between?(6,8)
	return "High School" if grade.between?(9,12)
	return "College"
end

puts "Enter grade: "
grade=gets.chomp.to_i
puts school_level(grade)
