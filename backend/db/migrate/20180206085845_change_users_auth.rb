class ChangeUsersAuth < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :password_digest, :string
    add_column :users, :name, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_expires_at, :datetime
    add_index :users, [:provider, :uid], unique: true
  end
end
