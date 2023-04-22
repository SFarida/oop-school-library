require './book'
require './teacher'
require './rental'
require './student'
class App
  def initialize
    @persons = []
    @books = []
    @rentals = []
  end

  def run
    option_list = [1, 2, 3, 4, 5, 6, 7]
    puts 'Welcome to School Library App !'
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
      case option
      when 1
        list_all_books
        run
      when 2
        list__all_people
        run
      when 3
        create_person
        run
      when 4
        create_book
        run
      when 5
        create_rental
        run
      when 6
        list_all_rentals_per_person
        run
      when 7
        puts 'Good bye!'
      end
    else
      puts 'Please enter a number between 1-6'
      run
    end
  end

  def list_all_books
    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
  end

  def list__all_people
    @persons.each { |person| puts "ID: #{person.id}, Name: #{person.name}, Age: #{person.age}" }
  end

  def create_person
    # 1 for student and 2 for teacher
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    profession = gets.to_i
    if [1, 2].include? profession
      print 'Age: '
      age = gets.to_i
      print 'Name: '
      name = gets.chomp
      if profession == 1
        print 'Has parent permission? [Y/N]: '
        has_parent_permission = gets.chomp
        @persons.push(Student.new(name, age, has_parent_permission))
      else
        print 'Specialization: '
        specialization = gets.chomp
        @persons.push(Teacher.new(name, age, specialization))
      end
      puts 'Person created successfully'
    else
      puts 'Please enter 1 or 2'
      create_person
    end
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @books.push(Book.new(title, author))
    puts 'Book created successfully'
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index} Title: '#{book.title}', Author: #{book.author}"
    end
    book_index = gets.to_i

    puts 'Select a person from the following list by number'
    @persons.each_with_index do |person, index|
      puts "#{index} [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.to_i

    print 'Date: '
    date_rented = gets.chomp
    @rentals.push(Rental.new(date_rented, @persons[person_index], @books[book_index]))
  end

  def list_all_rentals_per_person
    print 'ID of person: '
    person_id = gets.to_i
    puts 'Rentals: '
    @rentals.each do |rental|
      if rental.person.id == person_id
        puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
      end
    end
  end
end
