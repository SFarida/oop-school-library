require './book'
require './teacher'
require './rental'
require './student'
class App
  def initialize(opt)
    @persons = []
    @books = []
    @rentals = []
    @option = opt
  end

  def list_all_books
    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
    @option.list_options
  end

  def list__all_people
    @persons.each { |person| puts "ID: #{person.id}, Name: #{person.name}, Age: #{person.age}" }
    @option.list_options
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
        create_student(name, age)
      else
        create_teacher(name, age)
      end
      puts 'Person created successfully'
      @option.list_options
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
    @option.list_options
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
    @option.list_options
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
    @option.list_options
  end

  def create_student(name, age)
    print 'Has parent permission? [Y/N]: '
    has_parent_permission = gets.chomp
    @persons.push(Student.new(age, has_parent_permission, name))
  end

  def create_teacher(name, age)
    print 'Specialization: '
    specialization = gets.chomp
    @persons.push(Teacher.new(age, specialization, name))
  end
end
