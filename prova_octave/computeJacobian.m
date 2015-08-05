function J=computeJacobian(i,X,Z)

% prepare jacobian and fill its first two cols
jacobian = zeros(4,3);
jacobian(1:2, 1:2) = eye(2);


% extract i-th line
line_ith = Z(5:8,i);

% extract parts of homogeneous matrix X
rotMat = X(1:2, 1:2);
traMat = X(1:2, 3);

% compute products
tr_points = transformPoints(X, line_ith);
p_i = tr_points(1:2,:);
n_i = tr_points(3:4,:);
%p_i = rotMat*line_ith(1:2, :) + traMat;
%n_i = rotMat*line_ith(3:4, :);
%p_i = Z(1:2,i);
%n_i = Z(3:4,i);

% fill last col
jacobian(1:4, 3) = [-p_i(2) p_i(1) -n_i(2) n_i(1)]';

% output
J = jacobian; 

endfunction
