class CreatePersonalInformations < ActiveRecord::Migration[8.0]
  def change
    create_table :personal_informations do |t|
      t.references :resume, null: false, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
