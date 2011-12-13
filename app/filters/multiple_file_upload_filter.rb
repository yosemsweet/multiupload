module MultipleFileUploadFilter
	
	def self.map_multiple_uploads(params)
		assets_attributes = params["assets_attributes"]
		
		params["assets_attributes"] = array_to_indexed_hash(assets_attributes) if assets_attributes.kind_of?(Array)

		new_assets = {}
		params["assets_attributes"].try(:each) do |k, v|
			v = [v] unless v.kind_of? Array
			v.each do |asset|
				data = if asset[:data].kind_of? Array
						asset[:data]
					else
						[asset[:data]] 
					end
					
				data.each do |d|
					new_assets[new_assets.count.to_s] = { :data => d }
				end
			end
		end

		params["assets_attributes"] = new_assets unless new_assets.empty?
		params
	end
	
	private
	
	def self.array_to_indexed_hash(array)
		indexed_hash = {}

		array.each_index do | i |
			indexed_hash[i.to_s] = array[i]
		end
	
		return indexed_hash
	end
end