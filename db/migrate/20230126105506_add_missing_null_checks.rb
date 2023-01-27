class AddMissingNullChecks < ActiveRecord::Migration[6.1]
  def change
    change_column_null :questions, :title, false # this column cannot be a null
    change_column_null :questions, :body, false
    change_column_null :answers, :body, false
  end
end
