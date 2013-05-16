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
		@unit = Unit.new
		@units = Unit.all
	end

	def show
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private
	def parse_unit_params
		parse_dates(params[:unit])
  end

end