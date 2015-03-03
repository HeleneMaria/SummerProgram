class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.integer :reader_id

      t.timestamps null: false
    end
    
    add_index :books, [:reader_id, :created_at]
  end
end
