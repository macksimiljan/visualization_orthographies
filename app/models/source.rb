class Source < ApplicationRecord
  has_many :attestations
  has_many :morpho_syntaxes, through: :attestations
  has_many :orthographies, through: :attestations

  def typologies
    [typo_broad, typo_content, typo_form,
     typo_sociohistoric, typo_speccorpus, typo_subjectmatter].compact
  end

  def dating_interval
    [dating_start, dating_end].compact
  end
end
