class DashboardController < ApplicationController

	def index
		if cookies.signed[:user_id]
			@user = User.find_by(id: cookies.signed[:user_id])
		else
			flash[:alert] = "Login to access dashboard"
			redirect_to :login
		end
	end

	def new_user
		if cookies.signed[:user_id]
			@user = User.find_by(id: cookies.signed[:user_id])
			if @user.is_admin
				@user = User.new(firstname: params[:firstname],lastname: params[:lastname],email: params[:email])
			else
				redirect_to :dashboard
			end
		else
			flash[:alert] = "Login to access dashboard"
			redirect_to :login
		end
	end

	def list_users
		@offset = 2
		if params[:count] && params[:count].to_i < User.count 
			@count = params[:count].to_i
			@count = 0 if @count % @offset != 0
			@users = User.offset(@count).limit(@offset)
			@prev = (@count == 0) ? (User.count - @offset) : (@count - @offset)
			@count = @count + @offset
		else
			@count = 0
			@users = User.offset(@count).limit(@offset)
			@prev = 0
			@count = @count + @offset
		end
	end

	def search_box
	end

	def search_user
		if params[:search]
			@users = User.where('firstname LIKE :query || lastname LIKE :query',{query: "%#{params[:search]}%"})
		else
			flash[:alert] = "Invalid search query!"
			render :search_box
		end

	end

end