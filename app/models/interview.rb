class Interview < ApplicationRecord
    has_attached_file :resume
	validates_attachment :resume, :content_type => {:content_type => %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}
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
            cur_start = self.interview_starttime 
            cur_end = self.interview_endtime 
            all_interviews = Interview.all
            all_interviews.each do |schedule|
                if(schedule.id == self.id)
                    next
                end
                schedule_start = schedule.interview_starttime 
                schedule_end = schedule.interview_endtime 
                if(((schedule.interviewer_name == self.interviewer_name) || 
                   (schedule.interviewee_name == self.interviewee_name)) &&
                   ((cur_start >= schedule_start && cur_start <= schedule_end) || (cur_end >= schedule_start && cur_end <= schedule_end)) 
                  )
                  not_ok = true
                
                end
            end
            if(not_ok)
                errors.add(:start_time, "conflicts in this case.")
            end
        end
end
