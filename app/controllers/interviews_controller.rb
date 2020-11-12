class InterviewsController < ApplicationController
    def index
        @interviews = Interview.all
    end
    def new
        @interview = Interview.new
    end
    def create
        @interview = Interview.create(interview_params)
        if(@interview.errors.count == 0)
          redirect_to interviews_path
        else
          flash[:errors] = @interview.errors.full_messages
          redirect_to new_interview_path
        end
      end
    def show
        @interview = Interview.find(params[:id])
      end
    def edit
        @interview = Interview.find(params[:id])
      end
    def update
        @interview = Interview.find(params[:id])
        @interview.update(interview_params)
        # @interview.save!
        redirect_to(interview_path(@interview))
      end
    def destroy
        @interview = Interview.find(params[:id])
        @interview.destroy
        redirect_to interviews_path
      end
      private

      def interview_params
        params.require(:interview).permit(:interviewer_name, 
        :interviewee_name, :interviewer_email, :interviewee_email, 
        :interview_starttime, :interview_endtime, 
        :resume)
      end
end
