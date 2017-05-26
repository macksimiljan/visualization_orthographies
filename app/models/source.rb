class Source < ApplicationRecord
  has_many :attestations
  has_many :morpho_syntaxes, through: :attestations
  has_many :orthographies, through: :attestations
end
