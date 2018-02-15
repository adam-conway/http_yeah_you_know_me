require './test/test_helper'
require './lib/paths/word_search'

class WordSearchTest < MiniTest::Test
  def setup
    @word_search = WordSearch.new
  end

  def test_it_exists
    assert_instance_of WordSearch, @word_search
  end

  def test_it_initializes_with_dict
    assert_equal 235886, @word_search.dictionary.count
  end

  def test_string_fragment_against_dict
    real_word = "pizza"
    fake_word = "pizzzzzzzzza"

    assert_equal "pizza is a known word", @word_search.check_dictionary(real_word)
    assert_equal "pizzzzzzzzza is not a known word", @word_search.check_dictionary(fake_word)
  end
end
