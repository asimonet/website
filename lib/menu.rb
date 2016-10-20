def menu
	# Construct the list of pages
	pages = @items.select {|item| not item[:menu_order].nil? and item[:parent].nil? }
	pages.uniq!
	pages.sort! {|a, b| a[:menu_order].to_i <=> b[:menu_order].to_i}
	
	
	# Construct the HTML list
	list = ''
	pages.each do |item|
		# Is this page the active one?
		active = item[:menu_item] == @item[:menu_item]
		
		# Construct a menu element
		active_str = (active)? ' active' : ''
		list += ' ' + "<a class=\"blog-nav-item#{active_str}\" href=\"#{item.path}\">#{item[:menu_item]}</a>"
	end
	
	# Return the list
	list
end
