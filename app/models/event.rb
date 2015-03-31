class Event < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }
  validates :location, presence: true, length: { maximum: 255 }
  validates :date, presence: true
end
