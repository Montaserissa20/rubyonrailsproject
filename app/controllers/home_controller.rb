class HomeController < ApplicationController
  def index
   render json: { status: "running", message: "Server is working fine 🚀" }
  end
end
