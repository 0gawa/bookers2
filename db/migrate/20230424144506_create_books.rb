class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.title:string #本のタイトル
      t.body:string  #本の感想
      t.timestamps
    end
  end
end
