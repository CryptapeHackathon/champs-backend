class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :introduction
      t.string :address
      t.string :password_digest
      t.string :token
      t.string :bind_token

      t.timestamps
    end
  end
end
