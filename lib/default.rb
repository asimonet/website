# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

require 'nanoc/data_sources/bibtex_data_source'

def description
	if @item[:description].nil?
		'Personal webpage of Anthony SIMONET, Post-Doctoral Associate at Rutgers University.'
	else
		@item[:description]
	end
end
