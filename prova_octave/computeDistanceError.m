function [dist, gamma_sq] = computeDistanceError(Li, Lj, T, epsilon, alpha, e_max, angle_thresh, rho_thresh, max_dist_point)

% transform points
Lj_transf = transformPoints(T, Lj(1:4, :));
Lj_transf_RT = transformRT(Lj(5:6, :), t2v(T));
size(Lj)
size(Lj_transf_RT)

% output matrix
dist = zeros(size(Li, 2), size(Lj, 2));

% initial gamma value
gamma_sq = 1;


for i=1:size(Li, 2)
	% compute matrix for line rotation
	normal = Li(3:4, i);
	r_i = [normal(1) -normal(2); normal(2) normal(1)];

	% covariance matrices
	sigma_pi = r_i*[1 0; 0 epsilon]*r_i';
	sigma_ij = zeros(4,4);
	sigma_ij(1:2, 1:2) = sigma_pi;
	sigma_ij(3:4, 3:4) = alpha*eye(2);
	point_pi = Li(1:2, i);

	for j=1:size(Lj, 2)
		% compare angles
		%size(Li)
		%size(Lj)
		point_pj = Lj(1:2, j);
		point_pj_transf = T*([point_pj; 1]);
		dist_pi_pj = (point_pi(1)-point_pj_transf(1))^2 + (point_pi(2)-point_pj_transf(2))^2;
		%if ((abs(Li(6, i)-Lj(6, j)) > angle_thresh) || 
		%   (abs(Li(5, i)-Lj(5, j)) > rho_thresh) ||
        %   (dist_pi_pj>max_dist_point^2))
			if ((abs(Li(6, i)-Lj_transf_RT(2, j)) > angle_thresh) || 
		   (abs(Li(5, i)-Lj_transf_RT(1, j)) > rho_thresh) ||
           (dist_pi_pj>max_dist_point^2))


			dist(i, j) = Inf;
		else
			dist_pi_pj;
			% compute error
			error_ij = Li(1:4, i) - Lj_transf(1:4, j);
			%error_ij = computeError(1,T, [Li(1:4, i); Lj_transf(1:4, j)]);

			% ls error function
			ls_error = error_ij'*sigma_ij*error_ij;
			%ls_error = error_ij'*error_ij;

			% update gamma, if necessary
			%if(ls_error > e_max && e_max/ls_error > gamma_sq)
				%gamma_sq = e_max/ls_error;
			%endif

			% set current distance
			dist(i, j) = ls_error;
			
		endif
	endfor

endfor

endfunction
