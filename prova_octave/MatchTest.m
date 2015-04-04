% CONSTANTS
epsilon = 0.5;
alpha = 0.5;
last2_thresh = 0.1;
iterations = 50;
e_max = 1;

% read data
Pi = readFromFile("convertedLines_165.txt");
Pj = readFromFile("convertedLines_168.txt")
size(Pi)
size(Pj)

% initial homogeneous matrix
T = eye(4);
%T = v2t([0.1 0.1 0.05]);
%T = v2t([0 0 -0.300524]);

% initial matrices
Li = Pi(1:4, :);
%size(Li)
Lj = Li;
%Lj = Pj(1:4, :);
%Lj = Lj_temp(1:4, 1:size(Li, 2));


% loop
for i=1:iterations
	% matrix of distances
	size(Li)
	size(Lj)
	[dist, gamma_sqr] = computeDistanceError(Li, Lj, T, epsilon, alpha, e_max)

	% associations
	assoc = computeAssociations(dist, last2_thresh)

	if(size(assoc, 1) < 5)
		break;
	endif

	% new homogeneous matrix
	%Z = [Li; Lj];
	Z = compose_Z(Li, Lj, assoc)
	%size(Z)
	[xnew, chiNew]=lsIteration_gamma(t2v(T),Z, epsilon, alpha, gamma_sqr);
	T = v2t(xnew)


	% new matrices
	temp_li = [];
	temp_lj = [];

	%size(assoc)

	for j=1:size(assoc, 1)
		assoc_row = assoc(j, :);
		temp_li = [temp_li Li(1:4, assoc_row(1,1))];
		temp_lj = [temp_lj Lj(1:4, assoc_row(1,2))];
	endfor

	Li = temp_li;
	Lj = temp_lj;
	
endfor
