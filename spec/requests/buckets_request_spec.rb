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
					params = {
						"utf8"=>"✓", 
						"authenticity_token"=>"V7x7yoQQSMqkeWa2Mw2ohjcqh68XShqY6PrDGQsDBks=", 
						"bucket"=>{
							"name"=>"test", 
							"assets_attributes"=>
								{
									"0"=>
										{"_destroy"=>"0"}, 
									"1"=>
										{"data"=>[#<ActionDispatch::Http::UploadedFile:0x00000104ae8bc0 @original_filename="test.png", @content_type="image/png", @headers="Content-Disposition: form-data; name=\"bucket[assets_attributes][1][data][]\"; filename=\"test.png\"\r\nContent-Type: image/png\r\n", @tempfile=#<File:/var/folders/xz/s5_8w3z137d_t34fvkdy70t4000102/T/RackMultipart20111211-56637-rprc1p>>,
											 				#<ActionDispatch::Http::UploadedFile:0x00000104ae8af8 @original_filename="test.txt", @content_type="text/plain", @headers="Content-Disposition: form-data; name=\"bucket[assets_attributes][1][data][]\"; filename=\"test.txt\"\r\nContent-Type: text/plain\r\n", @tempfile=#<File:/var/folders/xz/s5_8w3z137d_t34fvkdy70t4000102/T/RackMultipart20111211-56637-19hm4wo>>]
										}
								}
							}, 
						"commit"=>"Save"
					}
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
