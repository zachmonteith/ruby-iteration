# require "./dictionary.txt"
require 'byebug'
result = []
dictionary = File.readlines("dictionary.txt").map { |word| word.chomp }



class Ghost
  attr_accessor :fragment, :dictionary, :current_player, :previous_player, :game_over

  def initialize(players, dictionary)
    @current_player = players[0]
    @previous_player = players[1]
    @fragment = ""
    @dictionary = dictionary
    @game_over = false
  end

  def play_round
    take_turn(@current_player)
    until @game_over
      next_player!
      play_round
    end

  end



  def next_player!
    @current_player, @previous_player = @previous_player, @current_player
  end

  def take_turn(player)
    puts "current fragment is #{@fragment}"
    guess = player.guess.to_s
    if valid_play?(guess)
      @fragment << guess
    else
      puts "invalid move, bro! try again"
      take_turn(player)
    end
  end

  def valid_play?(guess)
    testing = @fragment + guess
    counter = 0

    dictionary.each do |word|
      counter += 1 if word.include?(testing)
      return true if counter == 2
    end

    return false if counter == 0

    player_loses(@current_player)
  end

  def player_loses(player)
    puts "#{@previous_player.name} wins!"
    puts "Sorry #{@current_player.name}, you tried your best?"
    @game_over = true
  end
end



class Player
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def guess
    puts "gimme a letter #{@name}!"
    gets.chomp.downcase
  end

  def alert_invalid_guess
  end
end

if __FILE__ == $PROGRAM_NAME
  players = [Player.new("Bob"), Player.new("Billy")]
  game = Ghost.new(players, dictionary)
  game.play_round
end
