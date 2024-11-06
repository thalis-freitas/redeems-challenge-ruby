class AddFieldsToRedeemPages < ActiveRecord::Migration[7.1]
  def change
    add_column :redeem_pages, :name, :string, null: false
    add_column :redeem_pages, :active, :boolean, default: true, null: false
  end
end
