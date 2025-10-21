module Api
  module V1
    class TagsController < ApplicationController
      def index; render json: Tag.all; end
      def show;  render json: Tag.find(params[:id]); end
      def create
        tag = Tag.new(tag_params)
        return render json: tag, status: :created if tag.save
        render json: { errors: tag.errors.full_messages }, status: :unprocessable_entity
      end
      def update
        tag = Tag.find(params[:id])
        return render json: tag if tag.update(tag_params)
        render json: { errors: tag.errors.full_messages }, status: :unprocessable_entity
      end
      def destroy
        Tag.find(params[:id]).destroy
        head :no_content
      end
      private
      def tag_params; params.require(:tag).permit(:name); end
    end
  end
end
