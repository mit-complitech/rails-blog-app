class CommentsController < ApplicationController
  before_action :find_comment, only: %i[ show update destroy ]

  def index
		comments = Comment.all
    render json: { comments: CommentSerializer.new(comments).serializable_hash }, status: :ok
  end

  def show
		if @comment
			render json: { comment: CommentSerializer.new(@comment).serializable_hash }, status: :ok
		end
  end

  def create
    comment = Comment.new(create_params)
		if comment.save
			render json: { comment: CommentSerializer.new(comment).serializable_hash,  message: "Comment created successfully."  }, status: :ok
		else
			render json: { errors: comment.errors }, status: :unprocessable_entity
		end
	rescue Exception => e
		render json: { errors: e.message, message: "Oops! Something went wrong." }, status: :unprocessable_entity
  end

  def update
		if @comment.update(update_params)
			render json: { comment: CommentSerializer.new(@comment).serializable_hash, message: "Comment was successfully updated." }, state: :ok
		else
			render json: { error: "Something went wrong.." }, status: :unprocessable_entity
		end
  end

  def destroy
    if @comment.destroy
			render json: { message: "Comment successfully deleted" }, status: :ok
		else
			render json: { errors: @comment.errors }, status: :unprocessable_entity
		end
  end

  private

    def find_comment
      @comment = Comment.find(params[:id])
		rescue Exception => e
			render json: { error: "Comment not found." }, status: :not_found
    end

    def create_params
      params.require(:data).permit(:title, :body, :user_id, :commentable_id, :commentable_type)
    end

    def update_params
      params.require(:data).permit(:title, :description)
    end
end
