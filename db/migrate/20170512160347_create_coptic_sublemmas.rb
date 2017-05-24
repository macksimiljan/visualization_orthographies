class CreateCopticSublemmas < ActiveRecord::Migration[5.0]
  def change
    create_table :coptic_sublemmas do |t|
      t.string :label
      t.string :pos
      t.references :greek_lemma, foreign_key: true

      t.timestamps
    end
  end
end
