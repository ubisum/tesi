function dist = computeDistanceNM (ne_i, ne_j, alpha_factor, point_factor, T)

% output
dist = zeros(size(ne_i, 2), size(ne_j, 2));

for i=1:size(ne_i, 2)
	col_i = ne_i(:, i);
	mid_i = 0.5*[col_i(3)+col_i(5) col_i(4)+col_i(6)]';
	n_i = col_i(1:2, :);

	for j=1:size(ne_j, 2)
		col_j = ne_j(:, j);
%		temp_mid_j = 0.5*[ne_j(3)+ne_j(5) ne_j(4)+ne_j(6)]';
%		mid_j_rot = T*[temp_mid_j; 1];
%		mid_j = mid_j_rot(1:2, :);

%		n_j_temp = ne_j(1:2, j);
%		n_j = T(1:2, 1:2)*n_j_temp;

		mid_j = 0.5*[col_j(3)+col_j(5) col_j(4)+col_j(6)]';
		n_j = col_j(1:2, :);

		dist_n = n_i-n_j;
		dist_m = mid_i-mid_j;
		%size(dist_n)
		%size(dist_m)
		%size(alpha_factor*(dist_n'*dist_n) + point_factor*(dist_m'*dist_m))
		dist(i,j) = alpha_factor*(dist_n'*dist_n) + point_factor*(dist_m'*dist_m);
	endfor
endfor

endfunction
