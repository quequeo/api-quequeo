class CreateSections < ActiveRecord::Migration[8.0]
  def change
    create_table :sections do |t|
      t.string :title
      t.text :content
      t.references :resume, null: false, foreign_key: true

      t.timestamps
    end
  end
end
