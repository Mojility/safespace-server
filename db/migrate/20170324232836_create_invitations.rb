class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.string :email, size: 255
      t.string :token, size: 255
      t.references :room

      t.timestamps
    end
  end
end
