class Comment < ApplicationRecord
	validates :title, presence: true
	belongs_to :user
	belongs_to :commentable, polymorphic: true

	has_many :comments, as: :commentable, dependent: :destroy
end
