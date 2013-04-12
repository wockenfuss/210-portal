class QuestionsController < ApplicationController
	respond_to :js, :json

	def new
		@question = Question.new
	end

	def create
		@question = Question.new(params[:question])
		if @question.save

		else

		end
	end

	def edit
	end
	
	def update
	end

	def index
	end

	def show
	end
end
