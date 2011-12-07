require 'spec_helper'

describe Bucket do
	it "should have assets" do
		Bucket.new.should respond_to(:assets)	  
	end
end
