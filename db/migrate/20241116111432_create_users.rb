class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :given_name
      t.string :family_name
      t.timestamp :last_logged_in_at
      t.string :confirmation_token
      t.text :confirmation_redirect_url
      t.timestamp :confirmed_at
      t.timestamp :confirmation_sent_at
      t.string :reset_password_token
      t.text :reset_password_redirect_url
      t.timestamp :reset_password_sent_at
      t.integer :role

      t.index :email, unique: true
      t.index :confirmation_token, unique: true
      t.index :reset_password_token, unique: true

      t.timestamps
    end
  end
end
