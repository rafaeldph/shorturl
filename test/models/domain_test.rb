require "test_helper"

class DomainTest < ActiveSupport::TestCase
  test "url should exist" do
    assert_not domains(:no_url).valid?
  end

  test "url should be unique" do
    duplicate_domain = domains(:one).dup
    assert_not duplicate_domain.valid?
  end
end