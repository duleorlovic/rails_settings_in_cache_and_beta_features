class CreateMySettings < ActiveRecord::Migration[7.0]
  def change
    create_table :my_settings do |t|
      t.string :name
      t.text :value
      t.text :description

      t.timestamps
    end
  end
end
