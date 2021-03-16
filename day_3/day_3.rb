#Accept student detials with marks and display the same detais with percentage

class Student
	attr_accessor :roll, :name, :percentage, :marks
	
	def initialize
		@marks=Array.new
	end
	
	def getDetails
		print "Enter Roll No: "
		@roll=gets.chomp.to_i
		print "Enter Name: "
		@name=gets.chomp
		(0...5).each  do |index|
			print "Enter mark-#{index}: "
			@marks << gets.chomp.to_i
		end
	end
	
	def calc_percentage
		sum=0
		@marks.each{|a| sum+=a}
		@percentage=((sum/500).to_f)*100
	end
	
	def displayDetails
		calc_percentage
		puts "Roll No: #{@roll}, Name: #{@name}, Percentage #{@percentage}"
	end
end

students=Array.new
print "Enter no. of students: "
n=gets.chomp.to_i
n.times{|i| puts i}
n.times do |i|
	puts "Enter Student-#{i+1} details: "
	s=Student.new
	s.getDetails
	students << s
	puts
end

puts "--------------Students Details with percentage are--------------"

n.times{|i| students[i].displayDetails}
