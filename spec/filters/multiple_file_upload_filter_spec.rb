require 'spec_helper'

describe MultipleFileUploadFilter do
	describe '::map_multiple_uploads' do

		it 'should exist' do
			MultipleFileUploadFilter.should respond_to(:map_multiple_uploads)
		end

		it 'should accept one parameter' do
			MultipleFileUploadFilter.should respond_to(:map_multiple_uploads).with(1).argument
		end
		
		context 'passing in params with no assets_attributes' do
			let(:params) { {"these" => "params"}}

			it 'should return passed in params' do
				MultipleFileUploadFilter.map_multiple_uploads(params).should == params
			end
		end

		context 'passing in params with assets_attributes' do
			
			context 'as an array' do
				before(:each) do
					@assets = [Factory.attributes_for(:asset), Factory.attributes_for(:asset)]
				end

				let(:params) { { "assets_attributes" => @assets } }
			
				it 'should convert params to indexed hash format' do
					MultipleFileUploadFilter.map_multiple_uploads(params).should == 
					{ 
						"assets_attributes" => {
							"0" => @assets[0],
							"1" => @assets[1]
						}
					}
				end
				
				it "doesn't change params other than assets_attributes" do
					params["foo"] = "test"
					MultipleFileUploadFilter.map_multiple_uploads(params).should == 
					{ 
						"foo" => "test",
						"assets_attributes" => {
							"0" => @assets[0],
							"1" => @assets[1]
						}
					}
				end
			end
			
			context 'as an indexed hash' do
				before(:each) do
					@assets = [Factory.attributes_for(:asset), Factory.attributes_for(:asset)]
				end

				let(:params) { 
					{
						"assets_attributes" => {
							"0" => @assets[0],
							"1" => @assets[1]
						}
					} 
				}

				it 'should not change params' do
					MultipleFileUploadFilter.map_multiple_uploads(params).should == params
				end

				context 'with an array of assets inside an indexed hash' do
					before(:each) do
						@assets = [Factory.attributes_for(:asset), Factory.attributes_for(:asset)]
					end

					let(:params) { 
						{
							"assets_attributes" => {
								"0" => @assets
							}
						} 
					}

					it 'should extract assets into indexed hash' do
						MultipleFileUploadFilter.map_multiple_uploads(params).should ==
						{ 
							"assets_attributes" => {
								"0" => @assets[0],
								"1" => @assets[1]
							}
						}
					end
				end

				context 'with an array of data inside an asset inside an indexed hash' do
					before(:each) do
						tmp = File.new(Rails.root + 'spec/fixtures/files/test.txt')
						fileOne = Rack::Test::UploadedFile.new(tmp, "text/txt")
						tmp.close
						tmp = File.new(Rails.root + 'spec/fixtures/files/test.png')
						fileTwo = Rack::Test::UploadedFile.new(tmp, "image/png")
						tmp.close
						
						@assets = Factory.attributes_for(:asset, :data => [fileOne, fileTwo])
					end

					let(:params) { 
						{
							"assets_attributes" => {
								"0" => @assets
							}
						} 
					}

					it 'should extract assets into indexed hash' do
						MultipleFileUploadFilter.map_multiple_uploads(params).should ==
						{ 
							"assets_attributes" => {
								"0" => { :data => @assets[:data][0] },
								"1" => { :data => @assets[:data][1] }
							}
						}
					end
					
				end
			end
		end
	end
end
