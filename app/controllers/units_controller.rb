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
			@units = Unit.order('release_date, created_at')
			respond_with @units
			# flash[:notice] = "Unit created."
			# js_redirect_to(units_path)
		end
	end

	def index
		@quizzes = Quiz.all
		@lectures = Lecture.all
		@unit = Unit.new
		@units = Unit.order('release_date')
		respond_with do |format|
			format.html { render 'shared/manage', 
		  												:locals => {
		  														:resource_name => "unit",
		  														:resources => @units
		  														} }
		end
	end

	def show
	end

	def edit
		@quizzes = Quiz.all
		@lectures = Lecture.all
		@unit = Unit.find(params[:id])
		@component_index = @unit.components.count + 1
		respond_with @unit
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
		@unit = Unit.find(params[:id])
		@unit.destroy
		@units = Unit.order('release_date, created_at')
	end

	private
	def parse_unit_params
		parse_dates(params[:unit]) if params[:unit]
  end

end