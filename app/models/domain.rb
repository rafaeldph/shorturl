class Domain < ApplicationRecord
  has_many :short_urls
  validates :url, presence: true, uniqueness: true
end