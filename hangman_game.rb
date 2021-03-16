puts "HangMan Game"
require 'rest-client'
require 'json'



flag = true
while flag

	response = RestClient.get "https://random-word-api.herokuapp.com/word"
	str=(JSON.parse(response).to_s)[2..-1][0..-3]

	puts "Word is #{str}"

	count=str.length
	hang=5

	result_str=""
	(0...count).each{result_str<< "_"}

	while hang>0
		puts result_str
		print "Guess Letter: "
		s=gets.chomp
		if s=="" then next end
		
		if result_str.include?(s)
			puts "Letter was already used\n\n"
			next
		end
		
		if str.include?(s)
			puts "Correct guess..."
			(0...str.count(s)).each do
				position = str.index(s)
				result_str[position]=s
				str=str.sub(s, "1")
			end
		else
			print "Wrong guess...."
			hang-=1
			puts "Lives Left #{hang}"
		end
		
		if hang==0
			puts"You Lost..."
			break
		end
		if result_str.index('_')==nil
			break
		end
		puts
		puts
		count-=1
		
	end
	if hang>0 && result_str.index('_')==nil
		puts "********Congratulations, You Won.. ********"
	end
	
	print "Do you want to play again ? (Y/y for yes): "
	ch=gets.chomp
	flag=false if ch!='y'&& ch!='Y'
end
