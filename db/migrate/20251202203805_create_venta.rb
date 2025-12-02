class CreateVenta < ActiveRecord::Migration[8.1]
  def change
    create_table :venta do |t|
      t.date :fecha
      t.decimal :total
      t.references :user, null: false, foreign_key: true
      t.integer :dni_comprador
      t.text :NyA_comprador

      t.timestamps
    end
  end
end
