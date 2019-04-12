class LotteryTicket
	attr_accessor :tickets

	def initialize
		puts "How many tickets would you like to enter?"
		number = gets.to_i

		@tickets = Array.new
		@array_winning_tickets = Array.new
		@count_of_matching_numbers = Array.new
		@array_counts_of_match = Array.new

		1.upto(number) do |n|
			puts "Please enter valid sequence of 6 numbers between 1 and 49 without repeating numbers"
			ticket = Array.new
			i = 0 

			while(i < 6) do
				num = gets.to_i
				if num > 0 && num < 50	
						if ticket.include? num
							puts "This number is already entered. Please enter another."
						else 
							ticket << num
							i +=1
						end
				else
					puts "Please enter a number between 1 and 49."
				end
			end
			puts "Your ticket's number is " + ticket.join(' ')

			@tickets << ticket
		end
	end

	def generate_winning_combination
		Array.new(6) {rand(1..49)}
	end

	def calculate_jackpot
		if @array_counts_of_match.any?{|x| x!=6}
			jackpot = 500000
		else
			jackpot = 1000000
		end

		jackpot = jackpot / @array_counts_of_match.count(6) if @array_counts_of_match.count(6) > 1
		jackpot
	end

	def get_award(count_of_matching_numbers)
		case count_of_matching_numbers
		when 3
			"20BGN"
		when 4
			"200BGN"
		when 5
			"2000BGN"
		when 6
			"#{calculate_jackpot}BGN"
		end
	end

	def get_winning_tickets_with_awards
		hash_winning_tickets = Hash.new
		i = 1

		@array_winning_tickets.each do |awt|
			hash_winning_tickets[i] = [awt[1], get_award(awt[0])]
			i += 1
		end

		puts "List of winning tickets with awards:" unless hash_winning_tickets.empty?
		hash_winning_tickets.each do |key, value|
			puts "Ticket #{key} with number #{value[0].join(' ')}: #{value[1]}"
		end
	end

	def get_winning_tickets
		winning_combination = generate_winning_combination
		#winning_combination = [3, 14, 43, 9, 35, 8]
		puts "Winning combination is " + winning_combination.join(' ')
	
		@tickets.each do |t|
			matching_numbers = t & winning_combination
			if matching_numbers.count >= 3
				@array_winning_tickets << [matching_numbers.count, t]
				@array_counts_of_match << matching_numbers.count
			end
		end
	end
end

ticket = LotteryTicket.new
ticket.get_winning_tickets
ticket.get_winning_tickets_with_awards

