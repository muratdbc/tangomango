class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :date
      t.string :address
      t.string :city
      t.string :area
      t.string :event_type
      t.string :state
      t.integer :zipcode
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longtitude, precision: 10, scale: 6
    end
  end
end
