require './book'
require './teacher'
require './rental'
require './student'
require './classroom'
require 'json'
require_relative 'util'
class App
  include Utilities
  attr_reader :persons, :books, :rentals

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

  def load_data
    load_books
    load_persons
    load_rentals
    puts 'Data loaded'
  end

  def load_books
    return unless File.exist?('books.json')

    File.foreach('books.json') do |json|
      book = JSON.parse(json)
      @books.push(Book.new(book['title'], book['author']))
    end
  end

  def load_persons
    return unless File.exist?('persons.json')

    File.foreach('persons.json') do |json|
      person = JSON.parse(json)
      if person['type'] == 'teacher'
        create_teacher(person['name'], person['age'], person['id'], person['specialization'])
      else
        create_student(person['name'], person['age'], person['id'], person['has_parent_permission'])
      end
      # p person['id']
    end
  end

  def load_rentals
    return unless File.exist?('rentals.json')

    File.foreach('rentals.json') do |json|
      rental = JSON.parse(json)
      person_index = @persons.find_index { |elt| elt.id == rental['person_id'] }
      book_index = @books.find_index { |elt| elt.title == rental['book_title'] }
      @rentals.push(Rental.new(rental['date'], @persons[person_index], @books[book_index]))
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
      if rental.person.id.to_i == person_id
        puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
      end
    end
    @option.list_options
  end

  def create_student(name, age, id = '', stored_permission = '')
    classroom = Classroom.new('General class')
    student = if id == ''
                print 'Has parent permission? [Y/N]: '
                permissions = %w[y n]
                has_parent_permission = gets.chomp.downcase
                input_permission = false
                if permissions.include? has_parent_permission
                  input_permission = has_parent_permission == 'y'
                else
                  create_student(name, age)
                end
                Student.new(age, classroom, name, parent_permission: input_permission)
              else
                Student.new(age, classroom, name, id, parent_permission: stored_permission)
              end
    student.classroom = classroom
    # p id
    @persons.push(student)
  end

  def create_teacher(name, age, id = '', stored_specialization = '')
    teacher = if id == ''
                print 'Specialization: '
                specialization = gets.chomp
                Teacher.new(age, specialization, name)
              else
                Teacher.new(age, stored_specialization, name, id)
              end
    @persons.push(teacher)
  end
end
