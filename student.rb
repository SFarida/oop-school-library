require './person'
class Student < Person
  def initialize(age, classroom, name = 'unknown', parent_permission = nil)
    super(name, parent_permission, age)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
