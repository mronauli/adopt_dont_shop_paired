class ChangeDefaultValueToAdoptableAttribute < ActiveRecord::Migration[5.2]
  def change
    change_column :pets, :adoptable, :boolean, default: true
  end
end
