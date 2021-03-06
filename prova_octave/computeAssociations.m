function [assoc] = computeAssociations(dist, last2_thresh)

	% initialize output
	assoc = [];
	chosen = [];
	dist;

	if (size(dist, 1) > 1)
		for i=1:size(dist, 1)
			% take a row
			row = dist(i, :);

			% compute min on the row
			min_row = min(min(row));

			% index of minimum value
			min_index = find(row == min_row);

			if(size(min_index, 2) == 1 && min_row != inf)
				% build a reduced row
				red_row = zeros(1, size(dist, 2)-1);
				%{
				if(min_index != 1)
					red_row(1, 1:min_index-1) = row(1, 1:min_index-1);
				endif

				if(min_index != size(row, 2))
					red_row(1, min_index:size(dist, 2)-1) = row(1, min_index+1:size(dist, 2));
				endif
				%}

				if(min_index == 1)
					red_row = row(1, 2:size(row,2));
				
				elseif(min_index == size(row,2))
					red_row = row(1, 1:size(row,2)-1);

				else
					red_row(1, 1:min_index-1) = row(1, 1:min_index-1);
					red_row(1, min_index:size(red_row,2)) = row(1, min_index+1:size(row,2));
				endif

				% new minimum value
				red_row_min = min(min(red_row));

				% create association
				ref_thresh = 0;
				if(red_row_min == inf)
					ref_thresh = min_row;
				else
					ref_thresh = red_row_min - min_row;
				endif

				if(ref_thresh < last2_thresh || ref_thresh == min_row)
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


assoc;
% repeated associations
rep = findRep(assoc);
temp_indeces = [];
%%{
for k=1:size(rep, 2)
	temp_mat = rep{1,k};
	temp_indeces = [temp_indeces; temp_mat];
endfor
assoc(temp_indeces, :) = [];
%%}
%remove repeated associations
%{
for k=1:size(rep, 2)
	temp_indeces = rep{1, k};
	size(temp_indeces);
	temp_indeces
	assoc

	%for z=1:size(temp_indeces, 1)
		%elem = temp_indeces(z, 1)
		assoc(temp_indeces, :) = [];
	%endfor
endfor
%}

%new_assoc = deleteRepAssocs(dist, rep, assoc);
%assoc = new_assoc;
endfunction
