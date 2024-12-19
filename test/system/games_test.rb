require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Games"
  # end
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Submitting a word that can't be built from the grid shows an error message" do
    visit new_url
    fill_in "word", with: "INVALIDWORD"
    click_on "Play"

    assert_text "Sorry but INVALIDWORD can't be built out of"
  end

  test "Submitting a one-letter consonant word that is not a valid English word shows an error message" do
    visit new_url
    letters = find(:css, '#letters', visible: false).value
    first_consonant_letter = letters.gsub(/[aeiou]/, '')[0]
    # p first_letter = find(:css, "li", visible: false)[0].text(:all)
    fill_in "word", with: first_consonant_letter
    click_on "Play"

    # p URI.parse(current_url).query

    assert_text "Sorry but #{first_consonant_letter} does not seem to be a valid English word..."
  end

  test "Submitting a valid English word according to the grid shows a success message" do
    visit new_url
    # letters = all('.letter').map(&:text).join
    letters = find(:css, '#letters', visible: false).value
    valid_word = letters.chars.sample(4).join
    p valid_word

    fill_in "word", with: valid_word
    click_on "Play"

    assert_text "Congratulations! #{valid_word} is a valid English word!"
  end
end
