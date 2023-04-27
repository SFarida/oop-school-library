require './person'
class Student < Person
  attr_reader :parent_permission

  def initialize(age, classroom, name = 'unknown', parent_permission = true, id = Random.rand(1..1000))
    super(age, name, id, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
