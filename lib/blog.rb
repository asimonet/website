include Nanoc::Helpers::Rendering
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::LinkTo

def paginate_articles
	article_groups = []
	articles_to_paginate = sorted_articles
	unpaginated = articles_to_paginate.clone
	
	until articles_to_paginate.empty?
		article_groups << articles_to_paginate.slice!(0..@config[:page_size]-1)
	end
	
	article_groups.each_with_index do |subarticles, i|
		title = 'News'
		identifier = '/news/'
		links = pagination_links(unpaginated, '/news/archive/', i)
		attributes = {
			:title => title,
			:menu_item => 'News',
			:menu_order => 10,
			:articles => subarticles,
			:links => links,
		}
		
		# If this is the first page, construct a second page with a simplified url
		if i == 0 then
			@items.create('', attributes, identifier)
		end
		
		# This one is always constructed
		title += " (page #{i+1})"
		identifier += "archive/#{i+1}/"
		# Setting a parent allows the menu to be displayed correctly
		attributes[:parent] = '/news/'
		@items.create('', attributes, identifier)
		puts @items[identifier][:parent]
	end
end

def pagination_links(articles, id_prefix, current_page)
	n_pages = (articles.size.to_f / @config[:page_size]).ceil.to_i
	content = ''

	# Previous
	if current_page == 0 then
		content += '<li class="disabled"><span>'
		content += '<span aria-hidden="true">&laquo;</span>'
		content += '</span>'
	else
		content += "<li><a href=\"#{id_prefix}#{current_page}\" aria-label=\"Previous\">"
		content += '<span aria-hidden="true">&laquo;</span></a>'
	end
	content += "</li>\n"
	
	for i in 1..n_pages do
		clazz = ''
		clazz = 'class="active"' if i == (current_page+1)
		
		content += "<li #{clazz}><a href=\"#{id_prefix}#{i}\">#{i}</a></li>\n"
	end

	# Next
	if current_page+1 == n_pages then
		content += '<li class="disabled"><span>'
		content += '<span aria-hidden="true">&raquo;</span>'
		content += '</span>'
	else
		content += "<li><a href=\"#{id_prefix}#{current_page + 2}\" aria-label=\"Next\">"
		content += '<span aria-hidden="true">&raquo;</span></a>'
	end
	content += "</li>\n"

	return content
end

def construct_abstract(article)
	pos =  article.compiled_content =~ /#{@config[:abstract_marker]}/
	
	if pos.nil?
		return article.compiled_content
	else
		return article.compiled_content[0..pos - 1]
	end
end

def format_date(date)
	parsed = Date.parse(date)
	day = parsed.strftime('%-d')
	
	case day
		when '1', '21', '31' then
			day += 'st'
		when '2', '22' then
			day += 'nd'
		when '3', '23' then
			day  += 'rd'
		else
			day += 'th'
	end
	
	return parsed.strftime("%A %B #{day} %Y")
end
