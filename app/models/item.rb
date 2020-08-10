class Item < ApplicationRecord
  MAX_CHARS_NAME = 36
  MAX_CHARS_DESC = 160
  MAX_IMAGE_BYTE_SIZE = 10_000_000

  belongs_to :category
  belongs_to :hashtag
  belongs_to :user
  belongs_to :city, optional: true

  has_many :upvotes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :upvoters, through: :upvotes, source: :user
  has_many :bookmarkers, through: :bookmarks, source: :user

  validates :name, :description, :address, presence: true
  validates :name, length: { minimum: 2, maximum: MAX_CHARS_NAME }
  validates :description, length: { minimum: 2, maximum: MAX_CHARS_DESC }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  scope :filter_by_category, -> (category_id) { where category_id: category_id }
  scope :filter_by_hashtag, -> (hashtag_id) { where hashtag_id: hashtag_id }
  scope :filter_by_city, -> (city_id) { where city_id: city_id }

  has_one_attached :photo
  validate :photo_present
  validate :photo_size, if: Proc.new { |p| p.photo.attached? }

  after_create :notify_subscribers

  scope :published_items, -> { where(approved: true).where(published: true) }
  scope :unapproved_items, -> { where(approved: false) }
  scope :archived_items, -> { where(published: false) }

  def photo_key
    if photo.attached?
      photo.key
    else
      'images_ydlatu'
    end
  end

  def notify_subscribers
    return unless Rails.env.production?
    approval_url = "https://www.scubo.life/admin/item?model_name=item&f%5Bapproved%5D%5B50286%5D%5Bv%5D=false"
    client = Twilio::REST::Client.new
    subscriber = Subscriber.first
    client.messages.create(
        from: "+442033897305",
        to: subscriber.phone_number,
        body: "New item to approve! \n  Author: #{self.user.nickname} \n Item: #{self.name} \n Description: #{self.description} \n \n #{approval_url}"
    )
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
