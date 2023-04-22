require './person'
class Student < Person

  def initialize(age, classroom, name = 'unknown', parent_permission: true)
    super(name, parent_permission, age)
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
