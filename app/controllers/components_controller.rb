class ComponentsController < ApplicationController
	before_filter :authenticate_user!
	
	respond_to :html, :js, :json

	def update 
		@component = Component.find(params[:id])
		@component.update_attributes(params[:component])
		puts "updating components"
		p @component
		respond_with @component
	end

	def destroy
		@component = Component.find(params[:id])
		@unit = @component.unit
		@component.destroy
		@component_index = @unit.components.count + 1
		respond_with @unit
	end
end