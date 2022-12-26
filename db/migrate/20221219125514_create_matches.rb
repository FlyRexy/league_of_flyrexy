class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.string :team1
      t.string :team2
      t.integer :time, array: true
      t.string :region
      t.string :result
    end
  end
end
