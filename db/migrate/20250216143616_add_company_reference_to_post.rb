class AddCompanyReferenceToPost < ActiveRecord::Migration[8.0]
  def change
    add_reference :posts, :company, null: false, foreign_key: true
    remove_column :posts, :user_id, :integer
  end
end
