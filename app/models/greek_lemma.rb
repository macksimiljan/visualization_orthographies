class GreekLemma < ApplicationRecord
  paginates_per 15

  def self.random_determinator_phrase
    adj_id, adjective = random_word('adject')
    noun_id, noun = random_word('noun')
    det = vowel?(adjective[0]) ? 'an' : 'a'
    {det: det, adj: adjective, noun: noun, adj_id: adj_id, noun_id: noun_id}
  end

  def self.random_word(pos)
    record = GreekLemma.where('pos LIKE ?', "%#{pos}%").where('meaning IS NOT NULL').where('LENGTH(meaning) > 2')
                        .order('RAND()')
                        .first
    meaning = record.meaning
    index_comma = meaning.include?(',') ? meaning.index(',') : meaning.length
    index_semicolon = meaning.include?(';') ? meaning.index(';') : meaning.length
    last_character = index_comma < index_semicolon ? index_comma : index_semicolon
    cleaned_meaning = self.cut_beginning_article(meaning[0...last_character].squish)
    return record.id, cleaned_meaning
  end

  private

  def self.vowel?(character)
    if character == 'i' || character == 'e' || character == 'a' ||
       character == 'o' || character == 'u'
      true
    else
      false
    end
  end

  def self.cut_beginning_article(phrase)
    articles = %w[a an the]
    space_index = phrase.index(' ')
    if space_index.nil?
      phrase
    else
      start = phrase[0...space_index]
      if articles.include?(start)
        phrase[space_index]
      else
        phrase
      end
    end
  end
end
