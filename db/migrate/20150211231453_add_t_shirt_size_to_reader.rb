class AddTShirtSizeToReader < ActiveRecord::Migration
  def change
    add_column :readers, :tShirtSize, :string
  end
end
