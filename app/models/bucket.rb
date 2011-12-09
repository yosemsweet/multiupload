class Bucket < ActiveRecord::Base
	has_many :assets, :as => :attachable
	accepts_nested_attributes_for :assets, :allow_destroy => true, :reject_if => lambda { |a| a[:data].blank? }
end
