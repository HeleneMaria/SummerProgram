class ChangeProgramToString < ActiveRecord::Migration
  def change
    change_column :readers, :program, :string
  end
end
