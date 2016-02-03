class UsersController < ApplicationController

	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

	def require_login
    redirect_to '/sessions/new' if session[:user_id] == nil
  end

  # def require_correct_user
  #   user = User.find(params[:id])
  #   redirect_to "/users/#{current_user.id}" if current_user != user
  # end

	def new
		# render 'new'
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		user = User.find(params[:id])
		if user.update(user_params)
			# @user = User.find(params[:id])
			redirect_to "/users/#{params[:id]}"
		else
			flash[:errors] = user.errors.full_messages
			redirect_to "/users/#{params[:id]}/edit"
		end
	end

	def destroy
		User.find(params[:id]).destroy
		redirect_to '/sessions/new'
	end

	def create
		user = User.new(user_params)
		if user.save
			session[:user_id] = user.id
			flash[:success] = "Successfuly added user"
			redirect_to "/users/#{user.id}"
		else 
			flash[:errors] = ["can't be blank", "invalid"]
			redirect_to "/users/new"
		end
	end

	def index
		user = Secret.all
		@secrets = user
	end

	def get_secrets
		@secrets = User.second

	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
end