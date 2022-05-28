class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.integer :genre_id
      t.string :name
      t.text :introduction
      t.integer :no_tax_price
      t.boolean :salling_status, default: true, null: false

      t.timestamps
    end
  end
end
