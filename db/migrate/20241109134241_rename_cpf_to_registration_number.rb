class RenameCpfToRegistrationNumber < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :cpf, :registration_number
  end
end
