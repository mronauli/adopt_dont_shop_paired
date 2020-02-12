class AddApproveToPets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :approve, :boolean, default: false
  end
end
