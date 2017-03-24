class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :body, size: 2048
      t.references :person
      t.references :room

      t.timestamps
    end
  end
end
