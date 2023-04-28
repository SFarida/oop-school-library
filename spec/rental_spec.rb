require './rental'
require './book'
require './student'
require './classroom'
describe Rental do
  context 'Testing class Rental' do
    it 'should create a Rental class' do
      bo = Book.new('title-1', 'author-1')
      classroom = Classroom.new('A')
      student = Student.new(14, classroom, 'alex')
      rental = Rental.new('23/04/23', student, bo)
      expect(rental.person.name).to eq('alex')
      expect(rental.book.title).to eq('title-1')
    end
  end
end
