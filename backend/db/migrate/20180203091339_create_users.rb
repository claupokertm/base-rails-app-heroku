class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto'
    create_table :users, id: :uuid do |t|
      t.string :username, null: false
      t.string :email
      t.string :password_digest, null: false
      t.boolean :verified, null: false, default: false
      t.integer :role, null: false, default: 0
      t.text :avatar_url

      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
