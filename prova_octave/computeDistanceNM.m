function dist = computeDistanceNM (ne_i, ne_j, alpha_factor, point_factor, T, rho_theta_i, rho_theta_j, angle_thresh, rho_thresh, points_pi,
                                   points_pj, max_dist_point)

% output
dist = zeros(size(ne_i, 2), size(ne_j, 2));

% transform ne_j
ne_j_transf = T(1:2,1:2)*ne_j(1:2, :);
transf_ex1 = T(1:2, 1:2)*ne_j(3:4, :) + repmat(T(1:2,3), 1, size(ne_j,2));
transf_ex2 = T(1:2, 1:2)*ne_j(5:6, :) + repmat(T(1:2,3), 1, size(ne_j,2));

ne_j_transf = [ne_j_transf; transf_ex1(1:2, :); transf_ex2(1:2,:)];

for i=1:size(ne_i, 2)
	col_i = ne_i(:, i);
	mid_i = 0.5*[col_i(3)+col_i(5) col_i(4)+col_i(6)]';
	n_i = col_i(1:2, :);

	for j=1:size(ne_j, 2)
		col_j = ne_j_transf(:, j);

		mid_j = 0.5*[col_j(3)+col_j(5) col_j(4)+col_j(6)]';
		n_j = col_j(1:2, :);

		dist_n = n_i-n_j;
		dist_m = mid_i-mid_j;
		dist(i,j) = alpha_factor*(dist_n'*dist_n) + point_factor*(dist_m'*dist_m);
		%{
		if(rho_theta_i(1,i) - rho_theta_j_transf(1,j) < rho_thresh || rho_theta_i(2,i) - rho_theta_j_transf(2,j) < angle_thresh
			|| dist_points_ij'*dist_points_ij < max_dist_point)
			dist(i,j) = alpha_factor*(dist_n'*dist_n) + point_factor*(dist_m'*dist_m);

		else
			dist(i,j) = inf;
		endif
		%}
	endfor
endfor

endfunction
