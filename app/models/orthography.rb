class Orthography < ApplicationRecord
  belongs_to :coptic_sublemma
  has_many :attestations
  has_many :morpho_syntaxes, through: :attestations
  has_many :sources, through: :attestations

  paginates_per 15
end
