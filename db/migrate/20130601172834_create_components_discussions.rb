class CreateComponentsDiscussions < ActiveRecord::Migration
	def change
    create_table :components_discussions do |t|
    	t.integer :component_id
    	t.integer :discussion_id
    end
	end
end
