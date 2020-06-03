class Scubo < ApplicationRecord
  belongs_to :category
  belongs_to :hashtag
  belongs_to :user

  validates :name, :description, :address, presence: true
end
