class SessionsController < ApplicationController
	def index
		render :index
	end

	# def destroy
	# 	session.clear
 #  		session[:success] = true
 #  		redirect_to '/sessions/new'
 #  	end

	def create
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to "/users/#{user.id}"
		else
			flash[:errors] = ["Invalid Email/Password Combination"]
			redirect_to :back
		end
	end
end