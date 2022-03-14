class TicTacToe
	@@board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
	@@spaces_taken = 0

	def show_board
		puts " #{@@board[0]} | #{@@board[1]} | #{@@board[2]} "
		puts "-----------"
		puts " #{@@board[3]} | #{@@board[4]} | #{@@board[5]} "
		puts "-----------"
		puts " #{@@board[6]} | #{@@board[7]} | #{@@board[8]} "
	end

	def check_for_winner(player)
		@player = player
		@winning_patterns = [
			[0, 1, 2],	#row 1
			[3, 4, 5],	#row 2
			[6, 7, 8],	#row 3
			[0, 3, 6],	#vertical row 1
			[1, 4, 7],	#veritcal row 2
			[2, 5, 8],	#vertical row 3
			[0, 4, 8],	#diagonal 1
			[2, 4, 6]		#diagonal 2
		]

		if @@spaces_taken >= 9
			return "congestion"
		else
			@winning_patterns.each do |pattern|
				if @@board[pattern[0]] == player && @@board[pattern[1]] == player && @@board[pattern[2]] == player
					return "winner"
				end
			end
		end
	end

	def player_input(space, player)
		@space = space -= 1
		if @@board[@space] == "X" || @@board[@space] == "O"
			puts "This space is already taken."
		elsif @space > 8
			puts "That is not a valid space."
		else
			@@board[@space] = player
			@@spaces_taken += 1
		end
	end
end

def shell
	game = TicTacToe.new
	while true do
		#Player 1's turn
		game.show_board
		puts "Player one, choose your space:"
		p1_input = gets.chomp.to_i
		game.player_input(p1_input, "X")

		p1_verdict = game.check_for_winner("X")
		if p1_verdict == "congestion"
			game.show_board
			puts
			puts "Oh dear, it seems we have a congestion. Neither player wins!... Lame."
			break
		elsif p1_verdict == "winner"
			game.show_board
			puts
			puts "We have a winner!"
			break
		end

		#Player 2's turn
		game.show_board
		puts "Player two, choose your space:"
		p2_input = gets.chomp.to_i
		game.player_input(p2_input, "O")
		game.check_for_winner("O")

		p2_verdict = game.check_for_winner("O")
		if p2_verdict == "congestion"
			game.show_board
			puts
			puts "Oh dear, it seems we have a congestion. Neither player wins!... Lame."
			break
		elsif p2_verdict == "winner"
			game.show_board
			puts
			puts "We have a winner!"
			break
		end
	end
end

shell