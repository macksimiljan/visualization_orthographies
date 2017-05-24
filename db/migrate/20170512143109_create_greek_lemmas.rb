class CreateGreekLemmas < ActiveRecord::Migration[5.0]
  def change
    create_table :greek_lemmas do |t|
      t.string :label
      t.string :meaning
      t.string :pos

      t.timestamps
    end
  end
end
