class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string  :title, null: false
      t.text    :description
      t.string  :status, null: false, default: "pending" # varsayılan durum: Bekliyor
      t.date    :due_date, null: false
      t.references :user, null: false, foreign_key: true   # user_id + index + FK
 
      t.timestamps
    end
  end
end
 