class CreateTeas < ActiveRecord::Migration[6.1]
  def change
    create_table :teas do |t|
      t.string :variety
      t.string :description
      t.float :temperature
      t.float :brew_time_in_min

      t.timestamps
    end
  end
end
