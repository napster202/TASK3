class InterviewsController < ApplicationController
    def index
        @interviews = Interview.all
    end
    def new
        @interview = Interview.new
    end
    def create
        @interview = Interview.create(interview_params)
        redirect_to interviews_path
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
        :interview_date, :interview_starttime, :interview_endtime)
      end
end
