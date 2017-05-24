class CreateOrthographies < ActiveRecord::Migration[5.0]
  def change
    create_table :orthographies do |t|
      t.string :label
      t.references :coptic_sublemma, foreign_key: true

      t.timestamps
    end
  end
end
