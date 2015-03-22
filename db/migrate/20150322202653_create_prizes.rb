class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.integer :level
      t.integer :reader_id

      t.timestamps null: false
    end
      add_index :prizes, [:reader_id]
  end
end
