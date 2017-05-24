class CreateSources < ActiveRecord::Migration[5.0]
  def change
    create_table :sources do |t|
      t.integer :dating_start
      t.integer :dating_end
      t.string :dialect
      t.string :manuscript
      t.string :text
      t.string :typo_broad
      t.string :typo_sociohistoric
      t.string :type_form
      t.string :typo_content
      t.string :typo_subjectmatter
      t.string :typo_speccorpus

      t.timestamps
    end
    add_index :sources, :dating_start
    add_index :sources, :dating_end
    add_index :sources, :dialect
  end
end
