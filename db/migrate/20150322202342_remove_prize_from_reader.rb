class RemovePrizeFromReader < ActiveRecord::Migration
  def change
    remove_column :readers, :prize, :Integer
  end
end
