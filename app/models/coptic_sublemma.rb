class CopticSublemma < ApplicationRecord
  belongs_to :greek_lemma

  paginates_per 15
end
