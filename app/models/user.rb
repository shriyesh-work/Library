class User < ApplicationRecord
  validates :firstname, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :lastname, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "not a valid email" }
  validates :password, length: { in: 6..20 }, confirmation: true

  before_save do 
    self.firstname = firstname.capitalize
    self.lastname = lastname.capitalize
    self.email = email.downcase
    self.username = email.split('@').first
  end

  after_save ThinkingSphinx::RealTime.callback_for(:user)

  def self.authenticate(user_params)
    user = find_by email: user_params[:email]
    if user.present? and user.password.eql? user_params[:password]
      user
    else
      nil
    end
  end
end