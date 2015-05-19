function [assoc] = computeAssociations(dist, last2_thresh)

	% initialize output
	assoc = [];
	chosen = [];
	dist

	if (size(dist, 1) > 1)
		for i=1:size(dist, 1)
			% take a row
			row = dist(i, :);

			% compute min on the row
			min_row = min(min(row));

			% index of minimum value
			min_index = find(row == min_row);

			if(size(min_index, 2) == 1 && min_index != inf)
				% build a reduced row
				red_row = zeros(1, size(dist, 2)-1);
				red_row(1, 1:min_index-1) = row(1, 1:min_index-1);
				red_row(1, min_index:size(dist, 2)-1) = row(1, min_index+1:size(dist, 2));

				% new minimum value
				red_row_min = min(min(red_row));

				% create association
				if(red_row_min - min_row > last2_thresh)
					% association
					assoc = [assoc; i min_index];
					chosen = [chosen; min_row];
				else
					chosen = [chosen; inf];		
				endif 
			else
			%chosen = [chosen; inf];		
			endif
	
		endfor
	%else
		%assoc = [assoc; 1 1];
	endif
chosen
endfunction
