class CommentSerializer
	include FastJsonapi::ObjectSerializer

	attributes :id, :title, :description, :updated_at, :created_at

	belongs_to :user

	has_many :comments

	attributes :article do |comment|
		comment.commentable_type == "Article" ? ArticleSerializer.new(comment.commentable, { fields: { article: [:title] }}) : nil
	end

	attributes :comment do |comment|
		comment.commentable_type == "Comment" ? CommentSerializer.new(comment.commentable, { fields: {comment: [:title] }}) : nil
	end
end
