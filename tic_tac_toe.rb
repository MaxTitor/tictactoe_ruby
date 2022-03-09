# I wasn't expecting any visitors. Sorry about the mess.

module GameStatus
	def self.check
		if GameBoard.board[0] == ["x", "x", "x"] ||
			 GameBoard.board[1] == ["x", "x", "x"] ||
			 GameBoard.board[2] == ["x", "x", "x"]
				"player wins"
		elsif GameBoard.board[0][0] == "x" &&
					GameBoard.board[1][0] == "x" &&
					GameBoard.board[2][0] == "x" ||
					GameBoard.board[0][1] == "x" &&
					GameBoard.board[1][1] == "x" &&
					GameBoard.board[2][1] == "x" ||
					GameBoard.board[0][2] == "x" &&
					GameBoard.board[1][2] == "x" &&
					GameBoard.board[2][2] == "x"
						"player wins"
		elsif GameBoard.board[0][0] == "x" &&
					GameBoard.board[1][1] == "x" &&
					GameBoard.board[2][2] == "x"
						"player wins"
		elsif GameBoard.board[0][2] == "x" &&
					GameBoard.board[1][1] == "x" &&
					GameBoard.board[2][0] == "x"
						"player wins"
		elsif GameBoard.board[0] == ["o", "o", "o"] ||
				 	GameBoard.board[1] == ["o", "o", "o"] ||
			 		GameBoard.board[2] == ["o", "o", "o"]
						"computer wins"
		elsif GameBoard.board[0][0] == "o" &&
					GameBoard.board[1][0] == "o" &&
					GameBoard.board[2][0] == "o" ||
					GameBoard.board[0][1] == "o" &&
					GameBoard.board[1][1] == "o" &&
					GameBoard.board[2][1] == "o" ||
					GameBoard.board[0][2] == "o" &&
					GameBoard.board[1][2] == "o" &&
					GameBoard.board[2][2] == "o"
						"computer wins"
		elsif GameBoard.board[0][0] == "o" &&
					GameBoard.board[1][1] == "o" &&
					GameBoard.board[2][2] == "o"
						"computer wins"
		elsif GameBoard.board[0][2] == "o" &&
					GameBoard.board[1][1] == "o" &&
					GameBoard.board[2][0] == "o"
						"computer wins"
		elsif GameBoard.board[0][0] != "." &&
					GameBoard.board[1][0] != "." &&
					GameBoard.board[2][0] != "." &&
					GameBoard.board[0][1] != "." &&
					GameBoard.board[1][1] != "." &&
					GameBoard.board[2][1] != "." &&
					GameBoard.board[0][2] != "." &&
					GameBoard.board[1][2] != "." &&
					GameBoard.board[2][2] != "."
						"draw"
		else
			"continue"
		end
	end
end

module Inputs
	def self.player
		puts "you are: x"
		print "select row: "
		@row = gets.chomp
		print "select space: "
		@space = gets.chomp
		if GameBoard.board[@row.to_i - 1][@space.to_i - 1] == "o"
			puts "You can't use that space, it's already taken by the computer"
			Inputs.player
		elsif GameBoard.board[@row.to_i - 1][@space.to_i - 1] == "x"
			puts "You can't use that space, you've already taken it"
			Inputs.player
		else
			TicTacToe.player_input(@row, @space)
		end
	end

	def self.cpu
		@row = rand(0..2)
		@space = rand(0..2)
		while GameBoard.board[@row][@space] == "x" ||
					GameBoard.board[@row][@space] == "o"
			@row = rand(0..2)
			@space = rand(0..2)
		end
		TicTacToe.cpu_input(@row, @space)
	end
end

class GameBoard
	@row_1 = [".", ".", "."]
	@row_2 = [".", ".", "."]
	@row_3 = [".", ".", "."]
	@board = [@row_1, @row_2, @row_3]

	def self.board
		@board
	end

	def self.place_moves(row, space, player)
		@board[row][space] = player.to_s
		puts
		GameBoard.show_board
		if GameStatus.check == "continue"
			if player.to_s == "x"
				Inputs.cpu
			else
				Inputs.player
			end
		elsif GameStatus.check == "player wins"
			puts
			puts "Player Wins!"
		elsif GameStatus.check == "computer wins"
			puts
			puts "Computer Wins!"
		elsif GameStatus.check == "draw"
			puts
			puts "Draw..."
		end
	end	

	def self.show_board
		@board.each do |row|
			p row.join
		end
	end
end

class TicTacToe < GameBoard
	include Inputs
	include GameStatus

	def initialize
		GameBoard.show_board
		Inputs.player
	end

	def self.player_input(row, space)
		@row = row.to_i - 1
		@space = space.to_i - 1
		@player = "x"
		GameBoard.place_moves(@row, @space, @player)
	end

	def self.cpu_input(row, space)
		@row = row.to_i
		@space = space.to_i
		@player = "o"
		GameBoard.place_moves(@row, @space, @player)
	end
end

TicTacToe.new