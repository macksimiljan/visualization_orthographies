class GreekLemma < ApplicationRecord
  paginates_per 15

  def self.random_determinator_phrase
    adj_id, adjective = random_word('adject')
    noun_id, noun = random_word('noun')
    det = vowel?(adjective[0]) ? 'an' : 'a'
    {det: det, adj: adjective, noun: noun, adj_id: adj_id, noun_id: noun_id}
  end

  # TODO: greek_lemma id: 1970, 2217 wird zu einem Leerzeichen beschnitten
  def self.random_word(pos)
    record = GreekLemma.where('pos LIKE ?', "%#{pos}%").where('meaning IS NOT NULL').where('LENGTH(meaning) > 2')
                        .order('RAND()')
                        .first
    meaning = record.meaning
    cleaned_meaning = postprocessing(meaning)
    return record.id, cleaned_meaning
  end

  def self.postprocessing(meaning)
    index_comma = meaning.include?(',') ? meaning.rindex(',')+1 : 0
    index_semicolon = meaning.include?(';') ? meaning.rindex(';')+1 : 0
    first_character = index_comma > index_semicolon ? index_comma : index_semicolon
    cleaned_meaning = meaning[first_character...meaning.length].squish
    if cleaned_meaning.include?('(') && cleaned_meaning.include?(')')
      index_open = cleaned_meaning.include?('(') ? cleaned_meaning.index('(') : 0
      index_close = cleaned_meaning.include?(')') ? cleaned_meaning.rindex(')')+1 : 0
      cleaned_meaning = cleaned_meaning[0...index_open] + cleaned_meaning[index_close...cleaned_meaning.length]
    end
    self.cut_beginning_article(cleaned_meaning.squish)
  end

  private

  def self.vowel?(character)
    c = character.downcase
    if c == 'i' || c == 'e' || c == 'a' ||
       c == 'o' || c == 'u'
      true
    else
      false
    end
  end

  def self.cut_beginning_article(phrase)
    words = phrase.split(' ')
    articles = %w[a an the]
    if articles.include? words[0]
      phrase[phrase.index(' ')+1...phrase.length]
    else
      phrase
    end
  end
end
