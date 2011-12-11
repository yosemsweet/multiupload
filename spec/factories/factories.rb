Factory.define :asset do |f|
	f.data { 
		tmp = File.new(Rails.root + 'spec/fixtures/files/test.txt')
		data = Rack::Test::UploadedFile.new(tmp, "text/txt")
		tmp.close
		data
	}		
end

Factory.define :image_asset, :class => 'asset' do |f|
	f.data { 
		tmp = File.new(Rails.root + 'spec/fixtures/files/test.png')
		data = Rack::Test::UploadedFile.new(tmp, "image/png")
		tmp.close
		data
	}		
end

Factory.define :bucket do |f|
  f.sequence(:name) { |n| "Bucket #{n}" }
end
