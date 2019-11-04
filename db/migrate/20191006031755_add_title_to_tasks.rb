class AddTitleToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :title, :string
    add_column :tasks, :start_date, :datetime
    add_column :tasks, :start_end, :datetime
  end
end
