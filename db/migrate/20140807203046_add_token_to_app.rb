class AddTokenToApp < ActiveRecord::Migration[4.2]
  def change
    add_column :apps, :token, :string
  end
end
