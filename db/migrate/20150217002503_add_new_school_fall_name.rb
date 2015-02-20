class AddNewSchoolFallName < ActiveRecord::Migration
  def change
    add_column :readers, :newSchoolFallName, :string
  end
end
