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

def publications(criteria)
   grouped_pubs = {}
   group_keys = nil
   pubs = @items.select{|item| not item[:bibtex].nil? }

   case criteria
   when 'year'
      pubs.each do |item|
         grouped_pubs[item[:year].to_i] = [] if grouped_pubs[item[:year].to_i].nil?
         grouped_pubs[item[:year].to_i].push item
      end

      group_keys = grouped_pubs.keys
      group_keys.sort! {|a,b| b <=> a}

   when 'type'
      pubs.each do |item|
         case item[:type].to_s
         when 'poster'
            group = 'Posters'
         when 'journal', 'article'
            group = 'Journals'
         when 'short', 'inproceedings'
            group = 'Conferences'
         when 'techreport'
            group = 'Reports'
         else
            group = 'Other'
         end

         grouped_pubs[group] = [] if grouped_pubs[group].nil?
         grouped_pubs[group].push item
      end

      group_keys = ['Conferences', 'Journals', 'Reports', 'Posters']
      group_keys.push 'Other' if not grouped_pubs['Other'].nil?
      group_keys.map {|k| grouped_pubs[k].sort! {|a,b| b[:year] <=> a[:year]}}
   end

	content = ''
	group_keys.each do |group|
      if grouped_pubs.include? group then
         content += render '/publications_list.*', {
            :group_name => group,
            :publications => grouped_pubs[group]
         }
      end
	end

	content
end
