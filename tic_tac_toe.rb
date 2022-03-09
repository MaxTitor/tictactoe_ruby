module Inputs
	def self.player
		puts
		puts "you are: x"
		print "select row: "
		@row = gets.chomp
		print "select space: "
		@space = gets.chomp
		TicTacToe.player_input(@row, @space)
	end

	def self.cpu
		@cpu_row = rand(0..2)
		@cpu_space = rand(0..2)
		while GameBoard.board[@cpu_row][@cpu_space] == "x"
			@cpu_row = rand(0..2)
			@cpu_space = rand(0..2)
		end
		TicTacToe.cpu_input(@cpu_row, @cpu_space)
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
		if player.to_s == "x"
			Inputs.cpu
		else
			Inputs.player
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
		@row = row.to_i - 1
		@space = space.to_i - 1
		@player = "o"
		GameBoard.place_moves(@row, @space, @player)
	end
end

game = TicTacToe.new