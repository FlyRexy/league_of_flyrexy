class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.string :name
      t.string :score
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
