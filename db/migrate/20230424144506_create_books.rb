class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title #本のタイトル
      t.string :body #本の感想
      t.integer :user_id #ユーザID
      t.float :star #星の評価

      t.integer :view_count, default: 0

      t.timestamps
    end
  end
end
