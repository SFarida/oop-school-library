require './book'

describe Book do
  context 'Testing class Book' do
    it 'should create a book' do
      bo = Book.new('title-1', 'author-1')
      expect(bo.title).to eq('title-1')
    end
  end
end
