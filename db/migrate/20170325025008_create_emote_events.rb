class CreateEmoteEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :emote_events do |t|
      t.references :person
      t.references :post
      t.references :emote

      t.timestamps
    end
  end
end
