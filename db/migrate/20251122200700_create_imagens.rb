class CreateImagens < ActiveRecord::Migration[8.1]
  def change
    create_table :imagens do |t|
      t.text :url
      t.references :producto, null: false, foreign_key: true

      t.timestamps
    end
  end
end
