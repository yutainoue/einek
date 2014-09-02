class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.string :name
      t.string :program
      t.string :stage
      t.string :map
      t.string :information

      t.timestamps
    end
  end
end
