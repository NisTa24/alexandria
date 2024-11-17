class AddCoverToBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :cover, :string
  end
end
