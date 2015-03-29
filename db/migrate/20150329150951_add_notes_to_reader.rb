class AddNotesToReader < ActiveRecord::Migration
  def change
    add_column :readers, :notes, :string
  end
end
