class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :desc
      t.decimal :cost
      t.references :fish, null: false, foreign_key: true

      t.timestamps
    end
  end
end
