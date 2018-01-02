require 'test_helper'

class BookTest < ActiveSupport::TestCase

  #test for name
  test 'name_cant_be_blank' do 
    book = Book.create(name: nil, author: 'Some Author', isbn: 1234567819, category: category(:comedy))

    puts book.errors.messages
  end
end