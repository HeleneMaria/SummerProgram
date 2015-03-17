class AddPrizeToReaders < ActiveRecord::Migration
  def change
    add_column :readers, :prize, :integer
  end
end
