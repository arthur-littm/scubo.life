class Item < ApplicationRecord
  MAX_CHARS_NAME = 36
  MAX_CHARS_DESC = 160
  MAX_IMAGE_BYTE_SIZE = 10_000_000

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

  has_one_attached :photo
  validate :photo_present
  validate :photo_size, if: Proc.new { |p| p.photo.attached? }

  def photo_key
    if photo.attached?
      photo.key
    else
      'images_ydlatu'
    end
  end

  private

  def photo_size
    if photo&.byte_size > MAX_IMAGE_BYTE_SIZE
      errors.add(:photo, 'is too large (10MB)')
    end
  end

  def photo_present
    unless photo&.attached?
      errors.add(:photo, 'is missing')
    end
  end
end
