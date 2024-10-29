class CreateRedeemPages < ActiveRecord::Migration[7.1]
  def change
    create_table :redeem_pages do |t|
      t.timestamps
    end
  end
end
