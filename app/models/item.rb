class Item < ApplicationRecord
  MAX_CHARS_NAME = 36
  MAX_CHARS_DESC = 200
  belongs_to :category
  belongs_to :hashtag
  belongs_to :user

  validates :name, :description, :address, presence: true
  validates :name, length: { minimum: 3, maximum: MAX_CHARS_NAME }
  validates :description, length: { minimum: 8, maximum: MAX_CHARS_DESC }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
