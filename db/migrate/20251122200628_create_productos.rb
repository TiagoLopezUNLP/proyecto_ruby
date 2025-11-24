class CreateProductos < ActiveRecord::Migration[8.1]
  def change
    create_table :productos do |t|
      t.string :nombre
      t.text :descripcion
      t.decimal :precio
      t.integer :stock
      t.date :fecha_ingreso
      t.date :fecha_modificacion
      t.date :fecha_baja
      t.integer :tipo
      t.integer :estado
      t.references :autor, null: false, foreign_key: true
      t.references :categoria, null: false, foreign_key: true

      t.timestamps
    end
  end
end
