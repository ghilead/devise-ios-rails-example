class ChangeUserOauthTokenToText < ActiveRecord::Migration
  def change
    change_column :users, :oauth_token, :text
  end
end
