class AddMeetupTable < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :location, null: false
      t.string :url, null: false

      t.timestamps
    end
    add_index :meetups, [:title, :url], unique: true

  end
end
