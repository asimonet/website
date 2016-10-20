# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

require 'nanoc/data_sources/bibtex_data_source'

def description
	if @item[:description].nil?
		'Personal webpage of Anthony SIMONET, post-doctoral researcher at Inria.'
	else
		@item[:description]
	end
end