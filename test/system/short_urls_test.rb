require "application_system_test_case"

class ShortUrlsTest < ApplicationSystemTestCase
  setup do
    @short_url = short_urls(:one)
  end

  test "visiting the index" do
    visit short_urls_url
    assert_selector "h1", text: "Short Urls"
  end

  test "creating a Short url" do
    visit short_urls_url
    click_on "New Short Url"

    fill_in "Domain", with: @short_url.domain_id
    fill_in "Short code", with: @short_url.short_code
    fill_in "Url", with: @short_url.url
    fill_in "Visits", with: @short_url.visits
    click_on "Create Short url"

    assert_text "Short url was successfully created"
    click_on "Back"
  end

  test "updating a Short url" do
    visit short_urls_url
    click_on "Edit", match: :first

    fill_in "Domain", with: @short_url.domain_id
    fill_in "Short code", with: @short_url.short_code
    fill_in "Url", with: @short_url.url
    fill_in "Visits", with: @short_url.visits
    click_on "Update Short url"

    assert_text "Short url was successfully updated"
    click_on "Back"
  end

  test "destroying a Short url" do
    visit short_urls_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Short url was successfully destroyed"
  end
end
