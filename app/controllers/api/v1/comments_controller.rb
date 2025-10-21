module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: [:show, :update, :destroy]

      def index
        article = Article.find(params[:article_id])
        render json: article.comments.includes(:user).as_json(include: { user: { only: [:id, :name] } })
      end

      def show
        render json: @comment
      end

      def create
        article = Article.find(params[:article_id])
        comment = article.comments.new(comment_params)
        if comment.save
          render json: comment, status: :created
        else
          render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @comment.update(comment_params)
          render json: @comment
        else
          render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @comment.destroy
        head :no_content
      end

      private
      def set_comment
        @comment = Comment.find(params[:id])
      end
      def comment_params
        params.require(:comment).permit(:body, :user_id)
      end
    end
  end
end
