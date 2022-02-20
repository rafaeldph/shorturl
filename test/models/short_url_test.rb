require "test_helper"

class ShortUrlTest < ActiveSupport::TestCase
  test "url should exist" do
    assert_not short_urls(:no_url).valid?
  end

  test "url and short code should be unique" do
    duplicate_short_url = short_urls(:one).dup
    assert_not duplicate_short_url.valid?
  end
end