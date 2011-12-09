require 'spec_helper'

describe "Buckets" do
	describe "GET /buckets" do
		it "works! (now write some real specs)" do
			get buckets_path
			response.status.should be(200)
		end
	end

	describe	"POST /buckets" do

		context "with valid params" do
			let(:params) { Factory.attributes_for(:bucket) }
			
			it "should redirect to the new bucket" do
				post "/buckets", :bucket => params
				response.should redirect_to(bucket_path(Bucket.last))
			end
		
			it "should create a new bucket" do
				lambda do
					post "/buckets", :bucket => params
				end.should change(Bucket, :count).by(1)
			end
		
			context "with asset parameters" do
				let(:params) {
					Factory.attributes_for(:bucket, 
						:assets_attributes => [ {:data => File.new(Rails.root + 'spec/fixtures/files/test.png')} ]
					) 
				}
				
				it "should redirect to the new bucket" do
					post "/buckets", :bucket => Factory.attributes_for(:bucket, 
						:assets_attributes => [ {:data => File.new(Rails.root + 'spec/fixtures/files/test.png')} ] 
					)
					response.should redirect_to(bucket_path(Bucket.last))
				end
				
				it "should create a new bucket and new assets" do
					lambda do
						post "/buckets", :bucket => params
					end.should change(Bucket, :count).by(1)
				end

			end
		end
	end
end
