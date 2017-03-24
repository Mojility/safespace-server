class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :room, size: 255

      t.timestamps
    end
  end
end
