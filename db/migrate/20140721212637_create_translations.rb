class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.text :literal
      t.belongs_to :text, index: true
      t.belongs_to :language, index: true

      t.timestamps
    end
  end
end
