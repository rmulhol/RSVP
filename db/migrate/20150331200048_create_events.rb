class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :date
      t.string :location
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :events, :users
  end
end
