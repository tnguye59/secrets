class SecretsController < ApplicationController

	  before_action :require_login, only: [:show, :create, :destroy]

	def require_login
    	redirect_to '/sessions/new' if session[:user_id] == nil
  	end

	def show
		@secrets = Secret.all
	end

	def create
		secret = Secret.new(secret_params)
		if secret.save
			redirect_to "/users/#{secret.user_id}"
		else
			flash[:errors] = comment.errors.full_messages
			redirect_to '/sessions/new'
		end
	end

	# def destroy
	# 	secret = Secret.find(params[:id])
	# 	redirect_to "/users/#{secret.user_id}"
	# end

	def destroy
    secret = Secret.find(params[:id])
    secret.destroy if secret.user == current_user
    redirect_to "/users/#{current_user.id}"
  end

	private
		def secret_params
			params.require(:secret).permit(:content, :user_id)
		end

end