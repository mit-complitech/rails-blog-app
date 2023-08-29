class ArticleSerializer
	include FastJsonapi::ObjectSerializer

  attributes :id, :title, :body, :updated_at, :created_at

	belongs_to :user
	
	has_many :comments
	
end
