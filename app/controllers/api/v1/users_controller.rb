module Api
  module V1
  	class UsersController < ApplicationController
  		before_action :find_user, only: %i[show]

  		def create
  			@user = User.new(user_params)
  			if @user.save!
          add_cart(@user)
  				render json: {user: @user}, status: :ok
  		  else
  		  	render json: {errors: @user.errors},
            status: :unprocessable_entity
  		  end
  		end
  	
  		def show
  			if @user.present?
  				render json: {user: @user}, status: :ok
  		  else
  		  	render json: {error: {message: "Record not found"}}, status: :ok
  		  end		
  		end
  	
  		private

      def user_params
  			params.require(:user).permit(:name, :email, :mobile_number)
  		end

  		def find_user
  			@user = User.find_by_id(params[:id]) if params[:id].present?
  		end

      def add_cart(user)
        Cart.find_or_create_by(user_id: user.id)
      end
  	end
  end
end  
