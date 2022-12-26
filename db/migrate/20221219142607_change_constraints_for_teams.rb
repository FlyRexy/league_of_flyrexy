class ChangeConstraintsForTeams < ActiveRecord::Migration[7.0]
  def change
    change_column :teams, :shortname, :string, unique: true
  end
end
