class Team < ApplicationRecord
  has_one_attached :logo do |attachable|
    attachable.variant :thumb, resize_to_limit: [30, 30]
    attachable.variant :match, resize_to_limit: [50, 50]
  end
  validates :name, :players, :coach, :shortname, :region, presence: true
  validates :name, :shortname, uniqueness: true
  validates :shortname, length: { minimum: 2, maximum: 4}
end
