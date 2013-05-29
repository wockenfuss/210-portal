class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.integer :component_index, :null => false
      t.references :unit, :null => false

      t.timestamps
    end

    create_table :components_lectures do |t|
    	t.integer :component_id
    	t.integer :lecture_id
    end

    create_table :components_quizzes do |t|
    	t.integer :component_id
    	t.integer :quiz_id 
    end
  end
end
