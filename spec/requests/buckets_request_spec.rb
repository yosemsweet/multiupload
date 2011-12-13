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
						:assets_attributes => [ Factory.attributes_for(:asset) ]
					) 
				}
				
				it "should redirect to the new bucket" do
					post "/buckets", :bucket => params
					response.should redirect_to(bucket_path(Bucket.last))
				end
				
				it "should create a new bucket" do
					lambda do
						post "/buckets", :bucket => params
					end.should change(Bucket, :count).by(1)
				end
				
				
				it "should create a new assets" do
					lambda do
						post "/buckets", :bucket => params
					end.should change(Asset, :count).by(1)
				end

			end
			
			
			context "with multiple asset parameters" do
				let(:valid_attributes) { Factory.attributes_for(:bucket) }
				
				it "should create a new bucket" do
					params = valid_attributes.merge(
						:assets_attributes => { "0" => Factory.attributes_for(:asset), 
								"1" => Factory.attributes_for(:image_asset) } 
					)
						
					lambda do
						post "/buckets", :bucket => params
					end.should change(Bucket, :count).by(1)
				end
				
				
				it "should create 2 new assets" do
					params = valid_attributes.merge(
						:assets_attributes => { 
							"0" => Factory.attributes_for(:asset), 
							"1" => Factory.attributes_for(:image_asset) 
						} 
					)
					
					lambda do
						post "/buckets", :bucket => params
					end.should change(Asset, :count).by(2)
				end

			end
			
			context "with actual parameters from live system" do
				it "should work" do
					tmp = File.new(Rails.root + 'spec/fixtures/files/test.txt')
					fileOne = Rack::Test::UploadedFile.new(tmp, "text/txt")
					tmp.close
					tmp = File.new(Rails.root + 'spec/fixtures/files/test.png')
					fileTwo = Rack::Test::UploadedFile.new(tmp, "image/png")
					tmp.close
					
					params = {
						"name"=>"test", 
						"assets_attributes"=> {
							"0"=> {"_destroy"=>"0"}, 
							"1"=> {"data"=>[fileOne, fileTwo ]}
						}
					}
					
					lambda do
						post "/buckets", :bucket => params
					end.should change(Bucket, :count).by(1)
				end
			end
		end
	end
	
	describe	"PUT /buckets/:id" do

		context "with valid params" do
			let(:bucket) { Factory.create(:bucket) }
			let(:params) { { :name => "Changed name" } }
			
			it "should redirect to the bucket show" do
				put "/buckets/#{bucket.id}", :bucket => params
				response.should redirect_to(bucket_path(bucket))
			end
		
			it "should update the bucket with passed params" do
				bucket.name.should_not == params[:name]
				put "/buckets/#{bucket.id}", :bucket => params
				bucket.reload.name.should == params[:name]
			end
		
			context "with asset parameters" do
				let(:params) { { :assets_attributes => { "0" => Factory.attributes_for(:asset) } } }
			
				it "should redirect to the bucket show" do
					put "/buckets/#{bucket.id}", :bucket => params
					response.should redirect_to(bucket_path(bucket))
				end
				
				it "should create a new asset" do
					lambda do
						put "/buckets/#{bucket.id}", :bucket => params
					end.should change(Asset, :count).by(1)
				end

			end
			
			
			context "with multiple asset parameters" do
				let(:params) { 
					{ 	
						:assets_attributes => { 
							"0" => Factory.attributes_for(:asset), 
							"1" => Factory.attributes_for(:image_asset) 
						} 
					}
				}
				
				it "should create 2 new assets" do
					
					lambda do
						put "/buckets/#{bucket.id}", :bucket => params
					end.should change(Asset, :count).by(2)
				end

			end
		end
	end
end
