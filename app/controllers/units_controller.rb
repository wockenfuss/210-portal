class UnitsController < ApplicationController
	before_filter :parse_unit_params, :only => [:create, :update]
	respond_to :js, :html, :json

	def new
		@unit = Unit.new
		respond_with @unit
	end

	def create
		@unit = Unit.create(params[:unit])
		if @unit.save
			flash[:notice] = "Unit created."
			js_redirect_to(units_path)
		end
	end

	def index
		@quizzes = Quiz.all
		@lectures = Lecture.all
		@unit = Unit.new
		@units = Unit.order('release_date')
	end

	def show
		@quizzes = Quiz.all
		@lectures = Lecture.all
		@unit = Unit.find(params[:id])
		@component_index = @unit.components.count + 1
		respond_with @unit
	end

	def edit
	end

	def update
		@unit = Unit.find(params[:id])
		if params[:lectures]  && params[:lectures] != ""
			@lecture = Lecture.find(params[:lectures])
			@component = @unit.components.create(:component_index => params[:component_index])
			@component.lectures << @lecture
		end
		if params[:quizzes] && params[:quizzes] != "" 
			@quiz = Quiz.find(params[:quizzes])
			@component = @unit.components.create(:component_index => params[:component_index])
			@component.quizzes << @quiz
		end
		if params[:data]
			@data = params[:data]
		end
		if params[:unit]
			@unit.update_attributes(params[:unit])
			js_redirect_to(unit_path(@unit))
		else
			@component_index = @unit.components.count + 1
			respond_with @unit, @data, @component_index
		end
	end

	def destroy
	end

	private
	def parse_unit_params
		parse_dates(params[:unit]) if params[:unit]
  end

end