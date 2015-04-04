function [dist, gamma_sq] = computeDistanceError(Li, Lj, T, epsilon, alpha, e_max)

% transform points
size(Lj)
Lj_transf = transformPoints(T, Lj(1:4, :));

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

	for j=1:size(Lj, 2)
		% compute error
		error_ij = Li(1:4, i) - Lj_transf(1:4, j);

		% ls error function
		ls_error = error_ij'*sigma_ij*error_ij;

		% update gamma, if necessary
		if(ls_error > e_max && e_max/ls_error > gamma_sq)
			gamma_sq = e_max/ls_error;
		endif

		% set current distance
		dist(i, j) = ls_error;
	endfor

endfor

endfunction
