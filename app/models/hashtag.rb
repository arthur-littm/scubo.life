class Hashtag < ApplicationRecord
  has_many :items, dependent: :destroy
end
