class AddOauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :oauth_token, :string

    change_column :users, :email, :string, :null => true
  end
end
