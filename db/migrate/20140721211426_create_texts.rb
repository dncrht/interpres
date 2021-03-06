class CreateTexts < ActiveRecord::Migration[4.2]
  def change
    create_table :texts do |t|
      t.text :literal
      t.boolean :accepted, null: false, default: false
      t.belongs_to :app, index: true

      t.timestamps
    end
  end
end
