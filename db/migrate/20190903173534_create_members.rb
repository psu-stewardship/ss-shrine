class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :original_filename
      t.references :work, foreign_key: true

      t.timestamps
    end
  end
end
