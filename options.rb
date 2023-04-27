require './app'
require_relative 'util'
require 'fileutils'
class Options
  include Utilities
  def initialize
    @app = App.new(self)
    @app.load_data
    list_options
  end

  def list_options
    option_list = [1, 2, 3, 4, 5, 6, 7]
    msg = 'Please choose an option by entering a number:
    1 - List all books
    2 - List all people
    3 - Create a person
    4 - Create a book
    5 - Create a rental
    6 - List all rentals for a given person id
    7 - Exit'
    puts msg

    option = gets.to_i
    # puts option
    if option_list.include? option
      call_methods(option)
    else
      puts 'Please enter a number between 1-7'
      list_options
    end
  end

  def call_methods(option)
    if option == 7
      save_data
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

  def save_data
    FileUtils.rm_f(%w[books.json persons.json rentals.json])
    @app.books.each { |book| save_book(book.title, book.author) }
    @app.persons.each do |person|
      if defined?(person.specialization).nil?
        save_student(person.id, person.age, person.name, person.parent_permission)
      else
        save_teacher(person.id, person.age, person.name, person.specialization)
      end
    end
    @app.rentals.each { |rental| save_rental(rental.date, rental.person.id, rental.book.title) }
  end
end
