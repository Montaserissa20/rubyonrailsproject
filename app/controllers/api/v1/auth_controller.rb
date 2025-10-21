# app/controllers/api/v1/auth_controller.rb
module Api
  module V1
    class AuthController < ApplicationController
      def login
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          render json: { message: "ok", user_id: user.id }
        else
          render json: { error: "invalid credentials" }, status: :unauthorized
        end
      end
    end
  end
end
