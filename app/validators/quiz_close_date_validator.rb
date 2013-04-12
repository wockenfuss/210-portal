class QuizCloseDateValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
  	if value && value != ""
	    unless value > object.release_date
	      object.errors[attribute] << (options[:message] || "must be after release date") 
	    end
  	end
  end
end