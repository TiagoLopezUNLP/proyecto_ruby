class AddReleaseYearToProductos < ActiveRecord::Migration[8.1]
  def change
    add_column :productos, :release_year, :integer
  end
end
