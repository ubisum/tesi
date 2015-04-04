function [xNew, chi]=lsIteration_gamma(x,Z, epsilon, alpha, gamma_sq)
	%initialize matrices and variables
	H=zeros(3,3);
	b=zeros(3,1);
	chi=0;

	% compose homogeneous matrix
	X=v2t(x); 
	

	for i=1:size(Z,2)
		% compute error
		e=computeError(i,X,Z);

		% compute jacobian
		J=computeJacobian(i,X,Z);

		% compute matrix for line rotation
		normal = Z(3:4, i);
		r_i = [normal(1) -normal(2); normal(2) normal(1)];

		% covariance matrices
		sigma_pi = r_i*[1 0; 0 epsilon]*r_i';
		sigma_ij = zeros(4,4);
		sigma_ij(1:2, 1:2) = sigma_pi;
		sigma_ij(3:4, 3:4) = alpha*eye(2);

		% scale covariance matrix
		sigma_ij *= gamma_sq;

		% local matrices
		h_ij = J'*sigma_ij*J;
		b_ij = J'*sigma_ij*e;

		% update global matrices
		H += h_ij;
		b += b_ij;
		chi+=e'*e;

	end

	% update global matrices
	dx=-H\b;
	dX = v2t(dx);
	xNew = t2v(dX*X);

endfunction
