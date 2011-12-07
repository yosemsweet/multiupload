class Asset < ActiveRecord::Base
	has_attached_file :data, :styles => { :large => "600x600", :medium => "300x300>", :thumb => "100x100>" }
	validates_attachment_presence :data
	
	belongs_to :attachable, :polymorphic => true
end
