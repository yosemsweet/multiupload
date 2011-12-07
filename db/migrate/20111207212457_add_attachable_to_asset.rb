class AddAttachableToAsset < ActiveRecord::Migration
  def change
		change_table :assets do |t|
			t.string 	:attachable_type
			t.integer	:attachable_id
		end
  end
end
