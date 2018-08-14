class CreateGamesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :games_users do |t|
      t.references :user, foreign_key: true
      t.references :game, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
