class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null:false, index: { unique: true }
      t.string :login, null:false
      t.string :password_digest
      t.string :favorite, array:true

      t.timestamps
    end
  end
end
