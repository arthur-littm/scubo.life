class Hashtag < ApplicationRecord
  has_many :items, dependent: :destroy
  validates :name, uniqueness: true

  def self.format(string)
    text = string.gsub("#", " ")
    .gsub(" ", "")
    .split(/(?=[A-Z])/).join(" ")
    return "# #{text}"
  end
end
