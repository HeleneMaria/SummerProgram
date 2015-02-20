class CreateReaders < ActiveRecord::Migration
  def change
    create_table :readers do |t|
      t.string :firstName
      t.string :lastName
      t.string :phoneNumber
      t.string :email
      t.integer :age
      t.string :tShirtSize
      t.string :schoolFallName
      t.string :schoolFallGrade
      t.integer :program
      
      t.timestamps null: false
    end
  end
end
