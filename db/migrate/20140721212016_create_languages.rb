class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :iso
      t.string :name

      t.timestamps
    end

    create_table :apps_languages, id: false do |t|
      t.belongs_to :app
      t.belongs_to :language
    end
  end
end
