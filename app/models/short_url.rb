class ShortUrl < ApplicationRecord
  belongs_to :domain
  validates_presence_of :url
  before_create :set_fields

  private
    def set_fields
      range = [*'0'..'9',*'A'..'Z',*'a'..'z']
      self.short_code = Array.new(5) { range.sample }.join
      set_fields if ShortUrl.exists?(short_code: self.short_code)

      self.visits = 0
    end
end