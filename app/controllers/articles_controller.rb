class ArticlesController < ApplicationController
  before_action :find_article, only: %i[ show edit update destroy ]

	def index
		articles = Article.all
		render json: { articles: ArticleSerializer.new(articles).serializable_hash }, status: :ok
	end

	def show
		if @article
			render json: { article: ArticleSerializer.new(@article).serializable_hash, errors: nil }, status: :ok
		else
			render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
		end
	end

  def create
    @article = Article.new(create_params)

		if @article.save
			render json: { article: ArticleSerializer.new(@article).serializable_hash,  message: "article created successfully."  }, status: :created
		else
			render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
		end
  end

  def update
		if @article.update(update_params)
			render json: { article: ArticleSerializer.new(@article).serializable_hash,  message: "article updated successfully."  }, status: :ok
		else
			render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
		end
  end

  def destroy
    if @article.destroy
			render json: { message: "Article successfully deleted" }, status: :ok
		else
			render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
		end
  end

  private

	def find_article
		@article = Article.find(params[:id])
	rescue Exception => e
		render json: { error: "Article not found" }, status: :not_found
	end

	def create_params
		params.require(:data).permit(:title, :body, :user_id)
	end

	def update_params
		params.require(:data).permit(:title, :body)
	end

end
