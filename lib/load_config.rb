Link = Struct.new(:label, :url)

def load_config()
	conf = YAML::load(File.open('config.yaml'))

	conf.each do |key, val|
		@config[key.to_sym] = val
	end
	
	# Create links
	links = []
	@config[:links].each do |str|
		arr = str.split '|'
		link = Link.new
		link.label = arr[0]
		link.url = arr[1]
		links << link
	end
	
	@config[:links] = links
end
