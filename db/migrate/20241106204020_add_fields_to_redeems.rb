class AddFieldsToRedeems < ActiveRecord::Migration[7.1]
  def change
    add_reference :redeems, :user, null: false, foreign_key: true
    add_reference :redeems, :redeem_page, null: false, foreign_key: true
    add_reference :redeems, :address, null: false, foreign_key: true
    add_column :redeems, :status, :integer, null: false, default: 0
    add_reference :redeems, :size_option, foreign_key: true
  end
end
