class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.float :price
      t.string :status
      t.string :frequency
      t.references :user, null: false, foreign_key: true
      t.references :tea, null: false, foreign_key: true

      t.timestamps
    end
  end
end
