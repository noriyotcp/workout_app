class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.integer :duration_in_min, null: false
      t.text :workout, null: false
      t.date :workout_date, null: false
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
