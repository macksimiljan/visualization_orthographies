class MorphoSyntax < ApplicationRecord
  has_many :attestations
  has_many :morpho_syntaxes, through: :attestations
  has_many :sources, through: :attestations
end
