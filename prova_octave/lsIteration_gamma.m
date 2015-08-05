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
		normal *= 1./sqrt(normal'*normal);
		r_i = [normal(1) -normal(2); normal(2) normal(1)];

		% covariance matrices
		omega_pi = r_i'*[10 0; 0 epsilon]*r_i;
		omega_ij = zeros(4,4);
		omega_ij(1:2, 1:2) = omega_pi;
		omega_ij(3:4, 3:4) = alpha*eye(2);

		point_error=e'*omega_ij*e;
		scale=1;
		if (point_error>gamma_sq)
			scale = sqrt(gamma_sq/point_error);
		endif
		% scale covariance matrix
		omega_ij *= scale;

		% local matrices
		h_ij = J'*omega_ij*J;
		b_ij = J'*omega_ij*e;

		% update global matrices
		H += h_ij;
		b += b_ij;
		chi+=e'*omega_ij*e;

	end

	% update global matrices
	dx=-H\b
	dX = v2t(dx);
	xNew = t2v(dX*X);
endfunction
