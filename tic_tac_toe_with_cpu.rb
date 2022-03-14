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

	def return_board
		return @@board
	end

	attr_reader :winning_patterns

	def check_for_winner(player = nil)
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

		if player != nil
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

module Cpu
	def self.play
		game = TicTacToe.new
		@board = game.return_board

		# Pattern 1
		if @board[0] == "1" && @board[1] == "2" && @board[2] == "3"
			return 1
		elsif @board[0] == "O" && @board[1] == "2" && @board[2] == "3"
			return 2
		elsif @board[0] == "O" && @board[1] == "O" && @board[2] == "3"
			return 3
		end

		# Pattern 2
		if @board[3] == "4" && @board[4] == "5" && @board[5] == "6"
			return 4
		elsif @board[3] == "O" && @board[4] == "5" && @board[5] == "6"
			return 5
		elsif @board[3] == "O" && @board[4] == "O" && @board[5] == "6"
			return 6
		end

		# Pattern 3
		if @board[6] == "7" && @board[7] == "8" && @board[8] == "9"
			return 7
		elsif @board[6] == "O" && @board[7] == "8" && @board[8] == "9"
			return 8
		elsif @board[6] == "O" && @board[7] == "O" && @board[8] == "9"
			return 9
		end

		# Pattern 4
		if @board[0] == "1" && @board[3] == "4" && @board[6] == "7"
			return 1
		elsif @board[0] == "O" && @board[3] == "4" && @board[6] == "7"
			return 4
		elsif @board[0] == "O" && @board[3] == "O" && @board[6] == "7"
			return 7
		end

		# Pattern 5
		if @board[1] == "2" && @board[4] == "5" && @board[7] == "8"
			return 2
		elsif @board[1] == "O" && @board[4] == "5" && @board[7] == "8"
			return 5
		elsif @board[1] == "O" && @board[4] == "O" && @board[7] == "8"
			return 8
		end

		# Pattern 6
		if @board[2] == "3" && @board[5] == "6" && @board[8] == "9"
			return 3
		elsif @board[2] == "O" && @board[5] == "6" && @board[8] == "9"
			return 6
		elsif @board[2] == "O" && @board[5] == "O" && @board[8] == "9"
			return 9
		end

		# Pattern 7
		if @board[0] == "1" && @board[4] == "5" && @board[8] == "9"
			return 1
		elsif @board[0] == "O" && @board[4] == "5" && @board[8] == "9"
			return 5
		elsif @board[0] == "O" && @board[4] == "O" && @board[8] == "9"
			return 9
		end

		# Pattern 8
		if @board[2] == "3" && @board[4] == "5" && @board[6] == "7"
			return 3
		elsif @board[2] == "3" && @board[4] == "5" && @board[6] == "7"
			return 5
		elsif @board[2] == "3" && @board[4] == "5" && @board[6] == "7"
			return 7
		end

		@board.each do |space|
			if space != "X" && space != "O"
				return space.to_i
			end
		end
	end
end

class Shell
	include Cpu

	@@turn = 0
	@@player = "X"

	def initialize
		game = TicTacToe.new
		while true do

			if @@turn == 0
				@@player = "X"
			else
				@@player = "O"
			end

			game.show_board

			if @@player == "X"
				puts
				puts "Choose your space:"
				input = gets.chomp.to_i
			else
				input = Cpu.play
				puts
			end

			game.player_input(input, @@player)

			input = game.check_for_winner(@@player)
			if input == "congestion"
				game.show_board
				puts
				puts "Oh dear, it seems we have a congestion. Neither player wins!... Lame."
				break
			elsif input == "winner"
				game.show_board
				puts
				if @@player == "X"
					puts "Player 1 wins!"
				else
					puts "Player 2 wins!"
				end
				break
			end

			if @@turn == 0
				@@turn += 1
			else
				@@turn -= 1
			end
		end
	end
end

Shell.new