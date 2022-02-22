class ShortUrl < ApplicationRecord
  belongs_to :domain
  before_validation :set_domain
  validates_format_of :url, with: /\A((https?):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z0-9]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  before_create :set_code_and_visits

  private
    def set_code_and_visits
      range = [*'0'..'9',*'A'..'Z',*'a'..'z']
      self.short_code = Array.new(5) { range.sample }.join

      set_short_code_and_visits if ShortUrl.exists?(short_code: self.short_code)

      self.visits = 0
    end

    def set_domain
      complete_url = self.url.strip
      unless complete_url[/\Ahttp:\/\//] || complete_url[/\Ahttps:\/\//]
        complete_url = "http://#{self.url}"
      end

      uri = URI.parse(complete_url)
      self.domain = Domain.find_or_create_by(url: uri.host) unless uri.host.nil?
    end
end