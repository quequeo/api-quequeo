class CreateResumes < ActiveRecord::Migration[8.0]
  def change
    create_table :resumes do |t|
      t.string :title
      t.string :style
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
