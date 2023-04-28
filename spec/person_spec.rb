require './person'
describe Person do
  context 'Testing class Person' do

    it 'should create a Person class' do
      person = Person.new(12, 'Alex')
      older_person = Person.new(19, 'Tom')
      expect(person.age).to eq(12)
      expect(person.of_age).to eq(false)
      expect(older_person.of_age).to eq(true)
    end
  end
end