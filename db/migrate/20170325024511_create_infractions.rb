class CreateInfractions < ActiveRecord::Migration[5.0]
  def change
    create_table :infractions do |t|
      t.string :label, size: 255
      t.references :room

      t.timestamps
    end
  end
end
