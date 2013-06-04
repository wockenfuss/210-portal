class String
	def ellipsify(length)
		if self.size > length
			return self[0..length] + " ..."
		else
			return self
		end
	end
end