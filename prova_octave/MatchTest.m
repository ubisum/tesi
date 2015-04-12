% CONSTANTS
epsilon = 0.5;
alpha = 0.5;
last2_thresh = 0.1;
angle_thresh = 0.05;
rho_thresh = 0.3;
iterations = 50;
e_max = 1;

% read data
Pi = readFromFile("convertedLines_0.txt");
Pj = readFromFile("convertedLines_1.txt");
size(Pi)
size(Pj)

% initial homogeneous matrix
T = eye(3);
%T = v2t([0.1 0.1 0.05]);
%T = v2t([0 0 -0.300524]);

% initial matrices
Li = Pi(1:10, :);
%size(Li)
%Lj = Li;
Lj = Pj(1:10, :);
%Lj = Lj_temp(1:4, 1:size(Li, 2));
assoc = [];

% loop
for i=1:iterations
	% matrix of distances
	size(Li)
	size(Lj)
	[dist, gamma_sqr] = computeDistanceError(Li, Lj, T, epsilon, alpha, e_max, angle_thresh, rho_thresh);
	dist
	

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
		temp_li = [temp_li Li(1:10, assoc_row(1,1))];
		temp_lj = [temp_lj Lj(1:10, assoc_row(1,2))];
	endfor

	Li = temp_li;
	Lj = temp_lj;
	
endfor


% Pi's line extremes
transf_pi = Pi(7:10, :);

% transform Pj's line extremes
original_extremes = Pj(7:10, :);
transf_pj = [];
for counter=1:size(Pj, 2)
	coords = original_extremes(:, counter);
	up_transf = T*[coords(1) coords(2) 1]';
	lw_transf = T*[coords(3) coords(4) 1]';
	transf_coords = [up_transf(1) up_transf(2) lw_transf(1) lw_transf(2)];
	transf_pj = [transf_pj transf_coords'];
endfor

delete('transf_pi.txt');
fid_pi = fopen('transf_pi.txt','w');
for cnt_pi=1:size(transf_pi, 2)
	col_pi = transf_pi(:, cnt_pi);
	fprintf(fid_pi, "%f\t%f\n%f\t%f\n\n", col_pi(1), col_pi(2), col_pi(3), col_pi(4));
endfor

fclose(fid_pi);

delete('transf_pj.txt');
fid_pj = fopen('transf_pj.txt','w');
for cnt_pj=1:size(transf_pj, 2)
	col_pj = transf_pj(:, cnt_pj);
	size(col_pj)
	fprintf(fid_pj, "%f\t%f\n%f\t%f\n\n", col_pj(1), col_pj(2), col_pj(3), col_pj(4));
endfor

fclose(fid_pj);

delete('assoc_list.txt');
fid_assoc = fopen('assoc_list.txt', 'w');
for ass_count=1:size(assoc, 1)
	ass_couple = assoc(ass_count, :);
	left_line = Li(7:10, ass_couple(1));
	right_line = Lj(7:10, ass_couple(2));

	middle_point_i = 0.5*[left_line(1)+left_line(3) left_line(2)+left_line(4)];
	middle_point_j = 0.5*[right_line(1)+right_line(3) right_line(2)+right_line(4)];

	transf_mp_j = T*[middle_point_j'; 1];
	fprintf(fid_assoc, "%f\t%f\n%f\t%f\n\n", middle_point_i(1), middle_point_i(2), transf_mp_j(1), transf_mp_j(2));
endfor

fclose(fid_assoc);
T
printf("FATTO\n");

