class AddForeginKeys < ActiveRecord::Migration[5.0]
  def change
    add_column :attestations, :orthography_id, :integer
    add_column :attestations, :morpho_syntax_id, :integer
    add_column :attestations, :source_id, :integer

    add_foreign_key :attestations, :orthographies
    add_foreign_key :attestations, :morpho_syntaxes
    add_foreign_key :attestations, :sources
  end
end
