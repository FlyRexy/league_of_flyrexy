class AddColumnsToTeams < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :subs, :string, array:true
    add_column :teams, :shortname, :string
  end
end
