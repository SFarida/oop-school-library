require './book'
require './teacher'
require './rental'
require './student'
require 'json'
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

  def save_book(title, author)
    File.open('books.txt', 'a') do |f|
      f.write "{ \"title\": \"#{title}\", \"author\": \"#{author}\"} \n"
    end
  end

  def load_data
    return unless File.exist?('books.txt')

    File.foreach('books.txt') do |json|
      book = JSON.parse(json)
      @books.push(Book.new(book['title'], book['author']))
    end

    return unless File.exist?('persons.txt')

    File.foreach('persons.txt') do |json|
      person = JSON.parse(json)
      if person['specialization'].nil?
        @persons.push(Teacher.new(person['age'], person['specialization'], person['name']))
      else
        @persons.push(Student.new(person['age'], person['has_parent_permission'], person['name']))
      end
    end

    return unless File.exist?('rentals.txt')

    File.foreach('rentals.txt') do |json|
      rental = JSON.parse(json)
      @rentals.push(Rental.new(rental['date'], @persons[rental['person_index'].to_i], @books[rental['book_index'].to_i]))
    end

    puts 'Data loaded'
  end

  def save_student(age, name, has_parent_permission)
    File.open('persons.txt', 'a') do |f|
      f.write "{\"age\": \"#{age}\", \"has_parent_permission\": \"#{has_parent_permission}\", \"name\": \"#{name}\"} \n"
    end
  end

  def save_teacher(age, name, specialization)
    File.open('persons.txt', 'a') do |f|
      f.write "{\"age\": \"#{age}\", \"specialization\": \"#{specialization}\", \"name\": \"#{name}\"} \n"
    end
  end


  
  def save_rental(date, person_index, book_index)
    File.open('rentals.txt', 'a') do |f|
      f.write "{\"date\": \"#{date}\", \"person_index\": \"#{person_index}\", \"book_index\": \"#{book_index}\"} \n"
    end
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
    save_book(title, author)
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
    save_rental(date_rented, person_index, book_index)
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
    save_student(age, name, has_parent_permission)
  end

  def create_teacher(name, age)
    print 'Specialization: '
    specialization = gets.chomp
    @persons.push(Teacher.new(age, specialization, name))
    save_teacher(age, name, specialization)
  end
end
