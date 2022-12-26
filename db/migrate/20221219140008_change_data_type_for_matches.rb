class ChangeDataTypeForMatches < ActiveRecord::Migration[7.0]
  def change
    change_column(:matches, :time, :string, array:true)
  end
end
