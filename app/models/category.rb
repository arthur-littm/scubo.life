class Category < ApplicationRecord
  has_many :scubos, dependent: :destroy
end
