require 'test_helper'

class BookTest < ActiveSupport::TestCase

  test 'name_cant_be_blank' do 
    book = Book.create(name: nil, author: 'Some Author', isbn: 1234567819, category: category(:comedy))
    assert book.errors.full_messages.include? "Name can't be blank"
  end

  test 'author_cant_be_blank' do 
    book = Book.create(name: 'Some Book', author: nil, isbn: 1234567819, category: category(:comedy))
    assert book.errors.full_messages.include? "Author can't be blank"
  end

  test 'isbn_cant_be_blank' do 
    book = Book.create(name: 'Some Book', author: 'Some Author', isbn: nil, category: category(:comedy))
    assert book.errors.full_messages.include? "Isbn can't be blank"
  end

  test 'isbn_is_unique' do
    valid_book = Book.create(name: 'Some Book', author: 'Some Author', isbn: 1234512345, category: category(:comedy))
    invalid_book = Book.create(name: 'Some Book', author: 'Some Author', isbn: 1234512345, category: category(:comedy))
    assert invalid_book.errors.full_messages.include? "Isbn has already been taken"
  end

  test 'isbn_limited_to_13_characters' do 
    book = Book.create(name: 'Some Book', author: 'Some Author', isbn: 123456789101112, category: category(:comedy))
    assert book.errors.full_messages.include? "Isbn is too long (maximum is 13 characters)"
  end

  test 'isbn_only_numbers_allowed' do 
    book = Book.create(name: 'Some Book', author: 'Some Author', isbn: nil, category: category(:comedy))
    assert book.errors.full_messages.include? "Isbn is not a number"
  end

end