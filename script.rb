class Board
  attr_accessor :cells

  def initialize
    @cells = Array(1..9)
  end

  def display_board
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts '---+---+---'
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts '---+---+---'
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def update_cell(cell_number, player)
    @cells[cell_number.to_i - 1] = player.symbol
  end

  def valid_move?(cell_number)
    @cells[cell_number.to_i - 1].is_a?(Integer)
  end

  def win?
    WINNING_COMBINATIONS.each do |combo|
      return true if @cells[combo[0]] == @cells[combo[1]] && @cells[combo[1]] == @cells[combo[2]]
    end
    false
  end

  def tie?
    @cells.none? { |cell| cell.is_a?(Integer) } && !win?
  end

  WINNING_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ]
end

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Game
  def initialize
    @board = Board.new
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
    @current_player = @player1
  end

  def play
    puts 'Welcome to Tic Tac Toe!'
    puts '-----------------------'
    @board.display_board

    loop do
      player = @current_player == @player1 ? '1 using symbol X' : '2 using symbol O'
      puts "Player #{player}, it's your turn."
      cell_number = nil
      loop do
        puts 'Choose a cell (1-9):'
        cell_number = gets.chomp

        break if @board.valid_move?(cell_number)

        puts 'That cell is already taken. Choose another one.'
      end

      @board.update_cell(cell_number, @current_player)

      @board.display_board
      if @board.win?
        puts "Congratulations, #{@current_player}! You won!"
        break
      elsif @board.tie?
        puts "It's a tie!"
        break
      end
      switch_players
    end
  end

  private

  def switch_players
    @current_player = if @current_player == @player1
                        @player2
                      else
                        @player1
                      end
  end
end

game = Game.new
game.play
