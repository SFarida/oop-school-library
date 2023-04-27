require './person'
class Teacher < Person
  attr_reader :specialization

  def initialize(age, specialization, name = 'unknown', id = Random.rand(1..1000))
    super(age, name, id)
    @specialization = specialization
  end

  def can_use_services
    true
  end
end
