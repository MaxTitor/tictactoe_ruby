module Inputs
	@@input = Array.new
	def self.get
		puts "you are: x"
		print "select row: "
		@player_row = gets.chomp
		print "select space: "
		@player_space = gets.chomp
		GameBoard.input(@player_row, @player_space)
	end

	def self.cpu
		@cpu_row = rand(1..3)
		@cpu_space = rand(1..3)
	end
end

class GameBoard
	@row_1 = [".", ".", "."]
	@row_2 = [".", ".", "."]
	@row_3 = [".", ".", "."]
	@board = [@row_1, @row_2, @row_3]

	def self.input(row, space)
		@player_row = row.to_i - 1
		@player_space = space.to_i - 1
		@board[@player_row][@player_space] = "x"
		GameBoard.show_board
		Inputs.get
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
		Inputs.get
	end
end

game = TicTacToe.new