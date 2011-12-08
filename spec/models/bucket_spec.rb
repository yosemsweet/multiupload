require 'spec_helper'

describe Bucket do
	it "should have a name" do
		Factory.build(:bucket).should respond_to(:name)
	end
	
	it "should accept nested attributes for an asset" do
		expect {
			Factory.create(:bucket, :assets_attributes => [Factory.attributes_for(:asset)])
		}.to change( Asset, :count ).by 1
	end
end
