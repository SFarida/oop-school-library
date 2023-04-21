require './person'
class Teacher < Person
  def initialize(age, specialization, name = 'unknown', parent_permission = nil)
    super(name, parent_permission, age)
    @specialization = specialization
  end

  def can_use_services
    true
  end
end
