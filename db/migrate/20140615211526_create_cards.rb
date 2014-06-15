class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :word
      t.text :definition
      t.boolean :learned
      t.integer :user_id

      t.timestamps

    end
  end
end
