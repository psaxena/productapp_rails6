class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.integer :views, :default => 0
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
