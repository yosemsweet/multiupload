class Bucket < ActiveRecord::Base
	has_many :assets, :as => :attachable
end
