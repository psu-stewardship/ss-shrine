class AddFileDataToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :file_data, :text
  end
end
