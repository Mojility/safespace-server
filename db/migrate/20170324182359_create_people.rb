class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :handle, size: 64
      t.string :email, size: 255
      t.string :auth, size: 255

      t.timestamps
    end
  end
end
