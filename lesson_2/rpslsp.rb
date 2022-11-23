OPTIONS = %w(rock paper scissors lizard spock)

ABR_OPTIONS = %w[r p s l sp]

WIN_CONDITIONS = {
  rock: ['scissors', 'lizard'],
  paper:  ['rock', 'spock'],
  scissors: ['paper', 'lizard'],
  lizard: ['spock', 'paper'],
  spock: ['scissors', 'rock'] 
}

def prompt(message)
  puts "=> #{message}"
end

def valid_choice(choice)
  if ABR_OPTIONS.include?(choice)
    return true
  else
    prompt("You must enter a valid choice!")
  end
end

def decide_winner(player, computer)
  if player.to_s == computer
    prompt("It's a tie!")
  elsif WIN_CONDITIONS[player].include?(computer)
    prompt("You Won!")
  else
    prompt("Computer Wins!")
  end
end

def scoreboard(player_score, computer_score)
  puts "" #blank line between wins and scorecard
  prompt("XXXXX  SCOREBOARD XXXXX")
  prompt("XXXXX COMPUTER: #{computer_score} XXXXX")
  prompt("XXXXX  PLAYER: #{player_score}  XXXXX")
  prompt("XXXXXXXXXXXXXXXXXXXXXXX")
  puts "" #blank line after
end

choice = ""
player_score = 0
computer_score = 0

loop do
  loop do
    loop do
      prompt("Chose one: #{OPTIONS}")
      prompt("Type 'r' for Rock, 'p' for Paper, 's' for Scissors")
      prompt(" 'l' for Lizard, 'sp' for Spock")
        
      choice = gets.chomp.downcase
      break if valid_choice(choice)
    end
      
    converted_choice = case choice
                        when "l" then :lizard
                        when "sp" then :spock
                        when "r" then :rock
                        when "p" then :paper
                        when "s" then :scissors
                      end
      
    computer_choice = OPTIONS.sample 
      
    prompt("You chose #{converted_choice.to_s.capitalize} and the computer chose #{computer_choice.capitalize}")
      
    decide_winner(converted_choice, computer_choice)
      
    if WIN_CONDITIONS[converted_choice].include?(computer_choice)
      player_score += 1
    elsif WIN_CONDITIONS[computer_choice.to_sym].include?(converted_choice.to_s)
      computer_score += 1
    end
      
    scoreboard(player_score, computer_score)
    if computer_score == 3
      prompt("The computer has won! Better luck next time!")
      break
    elsif player_score == 3
      prompt("You've won the game! Thanks for playing!")
      break
    end
  end
  
  puts "" #blank line
  
  prompt("Would you like to play again? Y for yes")
  
  play_again = gets.chomp
  break unless play_again.downcase.start_with?('y')
  computer_score = 0
  player_score = 0
end