Factory.define :asset do |f|
	f.data File.new(Rails.root + 'spec/fixtures/files/test.txt')
end

Factory.define :bucket do |f|
  f.sequence(:name) { |n| "Bucket #{n}" }
end
