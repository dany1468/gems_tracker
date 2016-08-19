class TrackingGem < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
