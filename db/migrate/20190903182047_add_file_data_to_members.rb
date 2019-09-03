class AddFileDataToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :file_data, :text
  end
end
