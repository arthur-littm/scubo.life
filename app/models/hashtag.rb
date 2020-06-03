class Hashtag < ApplicationRecord
  has_many :scubos, dependent: :destroy
end
