class Orthography < ApplicationRecord
  belongs_to :coptic_sublemma

  paginates_per 15
end
