function Pt=transformPoints(X,P)

% create a new matrix to host points
tempMatrix = zeros(4, size(P,2));

% extract rotational and translational parts from X
rotMat = X(1:2, 1:2);
traMat = X(1:2, 3);

% separate points from normals
points = P(1:2, :);
normals = P(3:4,:);

% fill temp mat
tempMatrix(1:2, :) = rotMat*points + repmat(traMat, 1, size(P, 2));
tempMatrix(3:4, :) = rotMat*normals;

% generate output
Pt = tempMatrix;

endfunction
