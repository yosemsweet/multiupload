module MultipleFileUploadFilter
	
	def self.map_multiple_uploads(params)
		p_copy = params.clone
		assets_attributes = p_copy["assets_attributes"]
		
		p_copy["assets_attributes"] = array_to_indexed_hash(assets_attributes) if assets_attributes.kind_of?(Array)

		new_assets = {}
		p_copy["assets_attributes"].try(:each) do |k, v|
			v = [v] unless v.kind_of? Array
			v.each do |asset|
				if asset.has_key? :data
					data = if asset[:data].kind_of? Array
							asset[:data]
						else
							[asset[:data]] 
						end
					
					data.each do |d|
						new_assets[new_assets.count.to_s] = { :data => d }
					end
				else
						new_assets[new_assets.count.to_s] = asset
				end
			end
		end

		p_copy["assets_attributes"] = new_assets unless new_assets.empty?
		p_copy
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