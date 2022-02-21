class ShortUrl < ApplicationRecord
  belongs_to :domain
  validates_presence_of :url
  before_validation :check_domain
  before_create :set_code_and_visits
  attr_accessor :complete_url

  private
    def set_code_and_visits
      range = [*'0'..'9',*'A'..'Z',*'a'..'z']
      self.short_code = Array.new(5) { range.sample }.join

      set_short_code if ShortUrl.exists?(short_code: self.short_code)

      self.visits = 0
    end

    def set_domain
      uri = URI.parse(self.complete_url)
      raise ActiveRecord::RecordInvalid.new(self) if uri.host.nil?

      self.domain = Domain.find_or_create_by(url: uri.host)
    end

    def check_domain
      validate_url
      set_domain
    end

    def validate_url
      self.complete_url = self.url.strip
      unless self.complete_url[/\Ahttp:\/\//] || self.complete_url[/\Ahttps:\/\//]
        self.complete_url = "http://#{self.url}"
      end
      
      raise ActiveRecord::RecordInvalid.new(self) if (URI::regexp =~ self.complete_url).nil?
    end
end