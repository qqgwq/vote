class CreateTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.string :title
      t.text :content
      t.string :school
      t.string :name
      t.string :avatar
      t.timestamps
    end
  end
end
