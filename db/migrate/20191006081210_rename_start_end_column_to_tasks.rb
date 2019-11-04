class RenameStartEndColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :start_end, :end_date
  end
end
