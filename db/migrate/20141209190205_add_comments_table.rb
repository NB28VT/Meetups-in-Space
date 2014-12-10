class AddCommentsTable < ActiveRecord::Migration
  def change
    create_table :comments do |table|
      table.integer :user_id, null: false
      table.integer :meetup_id, null: false
      table.string :title
      table.text :body, null: false
      table.timestamps
    end
  end
end
