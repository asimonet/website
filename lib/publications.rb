def fix_author_list
	items = @items.select{|item| not item[:bibtex].nil? }
	
	items.each do |item|
		# Split the author list on 'and'
		bib_authors = item[:author]
		authors_array = bib_authors.split ' and '

		new_list = ''
		first = true

		authors_array.each do |author|
			# Now we have pairs of author like 'lastname, firstname'
			# We split it and reverse it
			splitted_author = author.split ','
			splitted_author.each_index{|i| splitted_author[i] = splitted_author[i].strip}
			splitted_author.reverse!

			# Construct the new list of authors
			if not first then
				new_list += ', '
			else
				first = false
			end
			
			new_list += splitted_author.join ' '
		end
		
		item[:author] = new_list
	end
end

def publications
	pubs = @items.select{|item| not item[:bibtex].nil? }

	grouped_pubs = {}
	pubs.each do |item|
		grouped_pubs[item[:year].to_i] = [] if grouped_pubs[item[:year].to_i].nil?
		grouped_pubs[item[:year].to_i].push item
	end
	
	group_keys = grouped_pubs.keys
	group_keys.sort! {|a,b| b <=> a}
	
	content = ""
	group_keys.each do |group|
		content += render '/publications_list.*', {
			:group_name => group,
			:publications => grouped_pubs[group]
		}
	end

	content
end
