module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :set_article, only: [:show, :update, :destroy, :attach_tag, :detach_tag]

      def index
        articles = Article.includes(:user, :tags).order(created_at: :desc)
        render json: articles.as_json(include: { user: { only: [:id, :name] },
                                                 tags: { only: [:id, :name] } })
      end

      def show
        render json: @article.as_json(include: [:tags, { user: { only: [:id, :name] } }])
      end

      def create
        article = Article.new(article_params)
        if article.save
          render json: article, status: :created
        else
          render json: { errors: article.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @article.update(article_params)
          render json: @article
        else
          render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @article.destroy
        head :no_content
      end

      # POST /api/v1/articles/:id/tags/:tag_id
      def attach_tag
        tag = Tag.find(params[:tag_id])
        @article.tags << tag unless @article.tags.exists?(tag.id)
        render json: @article.tags
      end

      # DELETE /api/v1/articles/:id/tags/:tag_id
      def detach_tag
        tag = Tag.find(params[:tag_id])
        @article.tags.destroy(tag)
        head :no_content
      end

      private
      def set_article
        @article = Article.find(params[:id])
      end

      def article_params
        params.require(:article).permit(:title, :body, :user_id)
      end
    end
  end
end
