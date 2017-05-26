class CreateAttestations < ActiveRecord::Migration[5.0]
  def change
    create_table :attestations do |t|
      t.integer :count

      t.timestamps
    end
  end
end
