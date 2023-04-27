require './nameable'
class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, :rental

  def initialize(age, name = 'Unknown', id = Random.rand(1..1000), parent_permission: true)
    super()
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rental = []
  end

  def of_age
    @age >= 18
  end

  def can_use_services
    return unless of_age || @parent_permission

    true
  end

  def correct_name
    @name
  end
end
