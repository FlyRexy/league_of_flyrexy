class AddColumnToTeams < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :region, :string
  end
end
