require './student'
require './classroom'
require './decorator'
describe Student do
  context 'Testing class Student' do
    it 'should create a student class' do
      classroom = Classroom.new('A')
      student = Student.new(14, classroom, 'alex')
      student.classroom = classroom
      expect(classroom.students[0].name).to eq('alex')
      expect(student.play_hooky).to eq('¯\(ツ)/¯')
      expect(student.correct_name).to eq('alex')
      capitalized_person = CapitalizeDecorator.new(student)
      expect(capitalized_person.correct_name).to eq('Alex')
    end
  end
end
