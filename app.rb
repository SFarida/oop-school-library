class App
  def run
    option_list = [1, 2, 3, 4, 5, 6]
    puts 'Welcome to School Library App !'
    puts ''
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    option = gets.to_i
    # puts option
    if option_list.include? option
      puts "Hello #{option}!"
    else
      puts 'Please enter a number between 1-6'
      run
    end
  end
end

def main
  app = App.new
  app.run
end

main