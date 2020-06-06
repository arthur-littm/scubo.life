class Item < ApplicationRecord
  MAX_CHARS_NAME = 36
  MAX_CHARS_DESC = 160
  belongs_to :category
  belongs_to :hashtag
  belongs_to :user

  validates :name, :description, :address, presence: true
  validates :name, length: { minimum: 2, maximum: MAX_CHARS_NAME }
  validates :description, length: { minimum: 2, maximum: MAX_CHARS_DESC }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  scope :filter_by_category, -> (category_id) { where category_id: category_id }
  scope :filter_by_hashtag, -> (hashtag_id) { where hashtag_id: hashtag_id }

end
