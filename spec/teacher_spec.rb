require './teacher'
require './decorator'
describe Teacher do
  context 'Testing class Teacher' do
    it 'should create a Teacher class' do
      teacher = Teacher.new(34, 'Network', 'maximilianus')
      expect(teacher.can_use_services).to eq(true)
      capitalized_teacher = CapitalizeDecorator.new(teacher)
      trimmed_teacher = TrimmerDecorator.new(capitalized_teacher)
      expect(capitalized_teacher.correct_name).to eq('Maximilianus')
      expect(trimmed_teacher.correct_name).to eq('Maximilian')
    end
  end
end
