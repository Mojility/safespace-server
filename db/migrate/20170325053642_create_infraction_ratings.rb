class CreateInfractionRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :infraction_ratings do |t|
      t.integer :rating
      t.references :infraction
      t.references :person

      t.timestamps
    end
  end
end
