class WordSearch
  attr_reader :dictionary
  def initialize
    @dictionary = File.read("/usr/share/dict/words").split
  end

  def check_dictionary(word)
    if @dictionary.include?(word)
      "#{word} is a known word"
    else
      "#{word} is not a known word"
    end
  end
end
