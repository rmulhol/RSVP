class Guest < ActiveRecord::Base
  belongs_to :event

  validates :name, presence: true, length: { maximum: 140 }
end
