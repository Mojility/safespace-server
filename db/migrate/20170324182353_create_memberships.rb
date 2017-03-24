class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.references :person_id
      t.references :room_id

      t.timestamps
    end
  end
end
