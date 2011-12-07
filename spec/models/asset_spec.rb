require 'spec_helper'

describe Asset do
	it { should have_attached_file(:data) }

	it "belongs to an attachable" do
	  Asset.new.should respond_to(:attachable)
	end

end
