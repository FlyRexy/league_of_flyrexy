class AddRegionToResults < ActiveRecord::Migration[7.0]
  def change
    add_column :results, :region, :string, default: "LCL"
  end
end
