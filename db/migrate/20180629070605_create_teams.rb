class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.integer :hackathon_id
      t.integer :user_id
      t.string :name
      t.text :introduction

      t.timestamps
    end
  end
end
