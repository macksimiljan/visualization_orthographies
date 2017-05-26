class Attestation < ApplicationRecord
  belongs_to :morpho_syntax
  belongs_to :orthography
  belongs_to :source


end
