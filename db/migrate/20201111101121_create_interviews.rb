class CreateInterviews < ActiveRecord::Migration[5.1]
  def change
    create_table :interviews do |t|
      t.string :interviewer_name
      t.string :interviewer_email
      t.string :interviewee_name
      t.string :interviewee_email
      t.date :interview_date
      t.time :interview_starttime
      t.time :interview_endtime

      t.timestamps
    end
  end
end
