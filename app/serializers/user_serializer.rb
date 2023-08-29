class UserSerializer
	include FastJsonapi::ObjectSerializer

  attributes :id, :name, :email, :phone, :updated_at, :created_at

	has_many :articles
	has_many :comments 
end
