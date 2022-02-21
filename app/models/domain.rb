class Domain < ApplicationRecord
  has_many :short_urls
  validates :url, presence: true, uniqueness: true
  before_create :set_alexa_rank

  private
    def set_alexa_rank
      url = URI.parse("https://awis.api.alexa.com/api?Action=UrlInfo&ResponseGroup=Rank&Output=json&Url=#{self.url}")
      req = Net::HTTP::Get.new(url.to_s)
      req.add_field('x-api-key', ENV['ALEXA_API_KEY'])
      res = Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == 'https') {|http| http.request(req) }
      
      response = JSON.parse(res.body)
      self.alexa_rank = response&.[]('Awis')&.[]('Results')&.[]('Result')&.[]('Alexa')&.[]('TrafficData')&.[]('Rank') || ""
    end
end
     
