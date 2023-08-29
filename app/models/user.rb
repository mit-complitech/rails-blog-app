class User < ApplicationRecord
	validates :name, :email, presence: true
	validates :email, uniqueness: true

	has_many :articles, dependent: :destroy
	has_many :comments, dependent: :destroy
end
