module ComponentsHelper

	def partialize(component)
    "#{stringify(component)}/display"
	end

	def stringify(component)
		 component.class.to_s.pluralize.downcase
	end

end