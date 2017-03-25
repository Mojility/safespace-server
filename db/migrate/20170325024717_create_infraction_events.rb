class CreateInfractionEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :infraction_events do |t|
      t.references :post
      t.references :infraction
      t.references :person

      t.timestamps
    end
  end
end
