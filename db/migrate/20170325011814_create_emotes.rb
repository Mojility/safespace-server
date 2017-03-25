class CreateEmotes < ActiveRecord::Migration[5.0]
  def change
    create_table :emotes do |t|
      t.string :label, size: 32
      t.string :code, size: 1

      t.timestamps
    end
  end
end
