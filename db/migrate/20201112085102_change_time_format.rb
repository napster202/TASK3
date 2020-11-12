class ChangeTimeFormat < ActiveRecord::Migration[5.0]
  def change
    change_column :interviews, :interview_starttime, :datetime
    change_column :interviews, :interview_endtime, :datetime
  end
end
