require_relative 'player'
require_relative 'question'

class Game
  def initialize
    @player1 = Player.new("Player 1")
    @player2 = Player.new("Player 2")
    @current_player = @player1
  end

  def play_turn
    question = Question.new
    player_answer = question.ask_question(@current_player)

    if player_answer == question.answer
      puts "#{@current_player.name}: Yes! You are correct."
    else
      puts "#{@current_player.name}: Seriously? No!"
      @current_player.lose_life
    end

    display_scores
    switch_player if @current_player.alive?
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def display_scores
    puts "Scores: #{@player1.name}: #{@player1.lives}/3 vs #{@player2.name}: #{@player2.lives}/3"
  end

  def game_over?
    !@player1.alive? || !@player2.alive?
  end

  def winner
    if @player1.alive?
      @player1
    else
      @player2
    end
  end

  def start_game
    puts "Welcome to the 2-Player Math Game!"
    until game_over?
      play_turn
    end
    puts "#{winner.name} wins with a score of #{winner.lives}/3!"
  end
end