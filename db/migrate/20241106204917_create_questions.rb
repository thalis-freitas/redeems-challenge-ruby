class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.references :redeem_page, null: false, foreign_key: true
      t.string :content, null: false

      t.timestamps
    end
  end
end
