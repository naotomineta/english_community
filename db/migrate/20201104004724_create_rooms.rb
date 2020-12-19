class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :title
      t.text :content
      t.integer :toeic_id
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
