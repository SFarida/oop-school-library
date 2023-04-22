require './app'
class Options
  def initialize
    @app = App.new(self)
    puts 'Welcome to School Library App!'
    list_options
  end

  def list_options
    option_list = [1, 2, 3, 4, 5, 6, 7]
    puts ''
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
    option = gets.to_i
    # puts option
    if option_list.include? option
      call_methods(option)
    else
      puts 'Please enter a number between 1-6'
      run
    end
  end

  def call_methods(option)
    if option == 7
      puts 'Good bye!'
    else
      options = {
        1 => :list_all_books,
        2 => :list__all_people,
        3 => :create_person,
        4 => :create_book,
        5 => :create_rental,
        6 => :list_all_rentals_per_person
      }
      @app.send(options[option])
    end
  end
end

def main
  Options.new
end

main
