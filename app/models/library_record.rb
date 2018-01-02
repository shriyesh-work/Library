class LibraryRecord < ApplicationRecord
  belongs_to :user
  belongs_to :book
end