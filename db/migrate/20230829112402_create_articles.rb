class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :body
			t.belongs_to :user

      t.timestamps
    end
  end
end
