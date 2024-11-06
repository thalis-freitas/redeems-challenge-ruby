class CreateRedeemPageSizeOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :redeem_page_size_options do |t|
      t.references :redeem_page, null: false, foreign_key: true
      t.references :size_option, null: false, foreign_key: true

      t.timestamps
    end

    add_index :redeem_page_size_options,
              [:redeem_page_id, :size_option_id],
              unique: true
  end
end
