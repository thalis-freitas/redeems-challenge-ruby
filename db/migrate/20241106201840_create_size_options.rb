class CreateSizeOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :size_options do |t|
      t.integer :size, null: false

      t.timestamps
    end
  end
end
