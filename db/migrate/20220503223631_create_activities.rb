class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.float :distance, null: false
      t.timestamps
    end
  end
end
