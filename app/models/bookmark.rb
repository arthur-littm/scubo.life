class Bookmark < ApplicationRecord
  belongs_to :scubo
  belongs_to :user
end