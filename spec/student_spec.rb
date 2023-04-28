require './student'
require './classroom'
require './decorator'
describe Student do
  context 'Testing class Student' do

    it 'should create a student class' do

      classroom= Classroom.new('A')
      student = Student.new(14,classroom,'alex')
      expect(student.play_hooky).to eq('¯\(ツ)/¯')
      expect(student.correct_name).to eq('alex')
      capitalizedPerson = CapitalizeDecorator.new(student)
      expect(capitalizedPerson.correct_name).to eq('Alex')

    end
  end
end