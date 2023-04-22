class Book
  attr_accessor :author, :title
  attr_reader :rental

  def initialize(title, author)
    @title = title
    @author = author
    @rental = []
  end
end
