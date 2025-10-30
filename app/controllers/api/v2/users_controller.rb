module Api
  module V2
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :update, :destroy]

      # New feature: now includes the user's full name and creation date in the response
      def index
        users = User.all.map do |u|
          {
            id: u.id,
            name: u.name,
            email: u.email,
            created_at: u.created_at.strftime("%Y-%m-%d"),
            full_profile: "#{u.name} (#{u.email})"
          }
        end
        render json: users
      end

      def show
        render json: {
          id: @user.id,
          name: @user.name,
          email: @user.email,
          created_at: @user.created_at.strftime("%Y-%m-%d"),
          full_profile: "#{@user.name} (#{@user.email})"
        }
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: {
            message: "User created successfully",
            user: {
              id: user.id,
              name: user.name,
              email: user.email
            }
          }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render json: { message: "User updated", user: @user }
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
        render json: { message: "User deleted successfully" }, status: :ok
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end
