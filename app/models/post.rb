class Post < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy

	validates :title, presence: true, allow_blank: false
  validates :body, presence: true, allow_blank: false
  validates :body, length: { minimum: 250 }
end
