class CreateApiKeys < ActiveRecord::Migration[7.2]
  def change
    create_table :api_keys do |t|
      t.string :key
      t.boolean :active

      t.index :key, unique: true
      t.timestamps
    end
  end
end
