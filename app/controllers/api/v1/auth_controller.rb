# app/controllers/api/v1/auth_controller.rb
module Api
  module V1
    class AuthController < ApplicationController
      def login
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
          # Create a JWT payload
          payload = { user_id: user.id, exp: 24.hours.from_now.to_i }

          # Encode the token
          token = JWT.encode(payload, JWT_SECRET, 'HS256')

          render json: { 
            message: "ok", 
            token: token, 
            user_id: user.id 
          }, status: :ok
        else
          render json: { error: "invalid credentials" }, status: :unauthorized
        end
      end
    end
  end
end
