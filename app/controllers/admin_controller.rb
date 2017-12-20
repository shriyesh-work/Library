class AdminController < ApplicationController
	
	def index
		if cookies.signed[:user_logged] 
			@user_logged = User.find(cookies.signed[:user_logged])
		else
			redirect_to :users
		end
	end

	def users 					
		@user_logged = User.find(cookies.signed[:user_logged])
		@users = User.all
		redirect_to user_home_path if not @user_logged.is_admin
	end

	def books
		@user_logged = User.find(cookies.signed[:user_logged])
		@books = Book.all
		redirect_to user_home_path if not @user_logged.is_admin
	end

	def search_users
	 @users = User.where('firstname LIKE :query || lastname LIKE :query || email LIKE :query',{query: "%#{params[:query]}%"})
	end
	
	def search_books
		@books = Book.where('name LIKE :query',{ query: "%#{params[:query]}%"})
	end
end