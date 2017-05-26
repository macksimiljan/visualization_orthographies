class CreateMorphoSyntaxes < ActiveRecord::Migration[5.0]
  def change
    create_table :morpho_syntaxes do |t|
      t.string :encoding

      t.timestamps
    end
  end
end
