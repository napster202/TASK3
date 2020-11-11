class Interview < ApplicationRecord
    has_attached_file :resume
	validates_attachment :resume, :content_type => {:content_type => %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}
    validates :interview_date, presence: true
    validates :interview_starttime, presence: true
    validates :interview_endtime, presence: true
    validates :interviewer_name, presence: true
    validates :interviewee_name, presence: true
    validates :interviewee_email, presence: true
    validates :interviewer_email, presence: true
    validates :resume, presence: true

    validate :end_before_start
    validate :conflicts
    private
        def end_before_start
            if self.interview_endtime < self.interview_starttime
                errors.add(:interview_endtime, " cannot be less than start time")
            end
        end

        def conflicts
            not_ok = false
            cur_start = self.interview_starttime.to_i + self.interview_date.to_time.to_i
            cur_end = self.interview_endtime.to_i + self.interview_date.to_time.to_i
            all_interviews = Interview.all
            all_interviews.each do |schedule|
                schedule_start = schedule.interview_starttime.to_i + schedule.interview_date.to_time.to_i
                schedule_end = schedule.interview_endtime.to_i + schedule.interview_date.to_time.to_i
                if((schedule.interviewer_name == self.interviewer_name || 
                   schedule.interviewee_name == self.interviewee_name) &&
                   ((cur_start >= schedule_start && cur_start <= schedule_end) || (cur_end >= schedule_start && cur_end <= schedule_end)) &&
                   (schedule.interview_date == self.interview_date)
                  )
                  not_ok = true
                    
                end
            end
            if(not_ok)
                errors.add(:start_time, "conflicts ")
            end
        end
end
