puts "Enter number: "
num=gets.chomp.to_i
flag=0
(2..num/2).each do |s|
	if num%s==0
		puts "Not Prime"
		flag=1;
		break
	end
end
puts "Prime" if flag==0
