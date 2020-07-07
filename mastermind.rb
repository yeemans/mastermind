# class that contains functions for when the player wants to guess
class PlayerFunctions
  def self.set_pattern # sets the random pattern
    @@pattern = []
    for i in 0...4
      marble = rand(1...6)
      @@pattern.append(marble)
      # convert numbers to colors
      if @@pattern[i] == 1
        @@pattern[i] = "red"
        elsif @@pattern[i] == 2
          @@pattern[i] = "blue"
        elsif @@pattern[i] == 3
          @@pattern[i] = "yellow"
        elsif @@pattern[i] == 4
          @@pattern[i] = "green"
        elsif @@pattern[i] == 5
          @@pattern[i] = "white"
        elsif @@pattern[i] == 6
          @@pattern[i] = "black"
      end
    end
  end

    def self.make_guess # allows player to guess
      guess_array = []
      black_dots = 0
      white_dots = 0
      for i in 0...4
        puts("Guess: red,blue,yellow,green,white,black")
        guess = gets
        guess = guess.downcase()
        # filter out non alphanumeric chars
        guess = guess.gsub!(/\W+/, '')
        # filter out numbers
        for j in 0...guess.length
          if guess[j].to_i > 0
            guess[j] = ""
          end
        end
        guess_array.append(guess)
        if guess_array[i] == @@pattern[i]
          black_dots += 1
        elsif @@pattern.include?(guess_array[i])
          white_dots += 1
        end
        print guess_array
      end
      puts "\n" + "Black dots: " + black_dots.to_s()
      puts "\n" + "White dots: " + white_dots.to_s()
      if black_dots == 4
        print("you won")
        exit!
      end

        
    end
   
end

# class for when the player wants to make the pattern
class ComputerFunctions
  def self.make_pattern
    @@player_pattern = []
    for i in 0...4
      puts("Choose red,blue,yellow,green,white,or black")
      player_marble = gets
      @@player_pattern.append(player_marble)
      # take out non alphanumeric chars
      @@player_pattern[i].gsub!(/\W+/, '')
      # filter out numbers
      for l in 0...@@player_pattern.length
        if @@player_pattern[l].to_i > 0
          @@player_pattern[l] = ""
        end
      end
        # choose red if input is not color
      if player_marble != "red" && player_marble != "blue" &&
        player_marble != "yellow" && player_marble != "green" &&
        player_marble != "white" && player_marble != "black"
        @@player_pattern[i] = "red"
      end
        
    end
    print @@player_pattern
    return @@player_pattern
end


  def self.computer_guess
    computer_guess_array = []
    computer_trials = 0
    included = []
    # guess randomly the first time
    for z in 0...120 # high number to guarantee the computer SHOULD guess right
      computer_trials += 1
      for m in 0...4
        if computer_guess_array[m] != @@player_pattern[m]
          # convert numbers to colors
          # only change the guess if color is incorrect
          computer_marble = rand(1...7)
          if computer_marble == 1
            computer_marble = "red"
          elsif computer_marble == 2
            computer_marble = "blue"
          elsif computer_marble == 3
            computer_marble = "green"
          elsif computer_marble == 4
            computer_marble = "yellow"
          elsif computer_marble == 5
            computer_marble = "white"
          elsif computer_marble == 6
            computer_marble = "black"
          end
        end
        puts computer_marble 
      # choose random item from the included array, put it
      # at random index in computer_guess_array
      computer_guess_array.append(computer_marble)
      # clear out values that do not match player pattern
      for x in 0...computer_guess_array.count()
      # make array of colors included but in wrong position
        if @@player_pattern.include?(computer_guess_array[x]) && 
        computer_guess_array[x] != @@player_pattern[x] &&
        included.include?(computer_guess_array[x]) == false
          included.append(computer_guess_array[x])
          included = included.shuffle()
          print "included: "
          print included
          computer_guess_array.append(included)
          print "computer guesses: "
          print computer_guess_array
        end
        if computer_guess_array[x] != @@player_pattern[x]
          computer_guess_array.delete_at(x)
        end
      end

      if computer_guess_array == @@player_pattern
        print "computers guess:" 
        print computer_guess_array
        print "computer trials: "
        print computer_trials
        exit!
      end

      end
            end
        # if computer gets both color and position right, dont change
  end
end
def set_mode # lets player guess or pick
  puts("Guess or pick?")
  choice = gets
  choice = choice.downcase
  if choice == "guess\n"
    PlayerFunctions.set_pattern
    for k in 1...12 # give 12 guesses
      PlayerFunctions.make_guess
    end
  puts "you lost"
  print @@pattern
  elsif choice == "pick\n"
    ComputerFunctions.make_pattern
    ComputerFunctions.computer_guess
  end
end
set_mode
