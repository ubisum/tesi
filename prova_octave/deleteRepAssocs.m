function new_assocs = deleteRepAssocs(dist, rep, assoc)
new_assocs = assoc;
indeces = [];

for i=1:size(rep, 2)
	cur_mat = rep{1, i};
	cur_dist = zeros(size(cur_mat));

	for j=1:size(cur_mat, 1)
		row_idx = cur_mat(j);
		cur_dist(j) = dist(assoc(row_idx, 1), assoc(row_idx, 2));
	endfor

	min_dist = min(min(cur_dist));
	min_idx = find(cur_dist == min_dist);

	if(size(min_idx, 1) == 1)
		cur_mat(min_idx, :) = [];
	endif

	indeces = [indeces; cur_mat];
endfor
indeces
assoc
new_assocs(indeces, :) = []

endfunction
