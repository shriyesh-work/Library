class Book < ApplicationRecord
  belongs_to :category
  has_many :records
  validates :name, presence: true
  validates :author, presence: true
  validates :isbn, presence: true, uniqueness: true, length: { maximum: 13 }, format: { with: /\A[0-9]+\z/, message: "only allows digits(0-9)" }

  after_save ThinkingSphinx::RealTime.callback_for(:book)
end