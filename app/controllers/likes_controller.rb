class LikesController < ApplicationController
	def create
		like = Like.new(secret_id: params[:secret_id], user_id: session[:user_id])
		if like.save
			redirect_to "/users/secrets/#{session[:user_id]}"
		else
			flash[:errors] = product.errors.full_messages
			redirect_to "/user/#{session[:user_id]}"
		end
	end

	def unlike
		Like.find(params[:id]).destroy
		redirect_to "/users/secrets/#{params[:user_id]}"
	end


end