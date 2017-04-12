class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :room_id
      t.integer :user_id
    end
  end
end
