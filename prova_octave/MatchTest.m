% CONSTANTS
epsilon = 0.5;
alpha = 0.5;
last2_thresh = 0.2;
angle_thresh = 0.1;
rho_thresh = 0.1;
iterations = 50;
max_dist_point = 0.1;
e_max = 1;

alpha_factor = .5;
point_factor = .5;

% read data
% content of a column in Li or Lj:
%
% point_on_line_x
% point_on_line_y
% normal_x
% normal_y
% rho
% angle
% ex_1_x
% ex_1_y
% ex_2_x
% ex_2_y
Pi = readFromFile("convertedLines_0.txt");
Pj = readFromFile("convertedLines_1.txt");
printLines(Pi(7:10, :), 'Pi.txt', eye(3));
printLines(Pj(7:10, :), 'Pj_original.txt', eye(3));
%Pj = Pi;

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
dist = [];

% loop
for i=1:iterations
	% matrix of distances
	%[dist, gamma_sqr] = computeDistanceError(Li, Lj, T, epsilon, alpha, e_max, angle_thresh, rho_thresh, max_dist_point);
	%dist = computeDistanceRT(Li(5:6, :), Lj(5:6, :), T);
	ne_i = zeros(6, size(Li, 2));
	ne_j = zeros(6, size(Lj, 2));
	
	ne_i(1:2, :) = Li(3:4, :);
	ne_i(3:6, :) = Li(7:10, :);
	ne_j(1:2, :) = Lj(3:4, :);
	ne_j(3:6, :) = Lj(7:10, :);
	temp_dist = computeDistanceNM (ne_i, ne_j, alpha_factor, point_factor, T);
	%dist
	

	% associations
	temp_assoc = computeAssociations(temp_dist, last2_thresh);

	if(size(temp_assoc, 1) < 5)
		break;
	else
		assoc = temp_assoc;
		dist= temp_dist;
	endif

	% new homogeneous matrix
	%Z = compose_Z(Li, Lj, assoc);
	%[xnew, chiNew]=lsIteration_gamma(t2v(T),Z, epsilon, alpha, gamma_sqr);
	%T = v2t(xnew);


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

	%Z = compose_Z(Li, Lj, assoc);
	Z = [Li; Lj];
	gamma_sqr = 1;
	[xnew, chiNew]=lsIteration_gamma(t2v(T),Z, epsilon, alpha, gamma_sqr);
	T = v2t(xnew);
	
endfor


% Pi's line extremes
transf_pi = Li(7:10, :);

% transform Pj's line extremes
original_extremes = Lj(7:10, :);
transf_pj = [];
for counter=1:size(Lj, 2)
	coords = original_extremes(:, counter);
	up_transf = T*[coords(1) coords(2) 1]';
	lw_transf = T*[coords(3) coords(4) 1]';
	transf_coords = [up_transf(1) up_transf(2) lw_transf(1) lw_transf(2)];
	transf_pj = [transf_pj transf_coords'];
endfor

delete('transf_pi.txt');
fid_pi = fopen('transf_pi.txt','w');
%for cnt_pi=1:size(transf_pi, 2)
for cnt_pi=1:size(assoc, 1)
	col_pi = transf_pi(:, cnt_pi);
	fprintf(fid_pi, "%f\t%f\n%f\t%f\n\n", col_pi(1), col_pi(2), col_pi(3), col_pi(4));
endfor

fclose(fid_pi);

delete('transf_pj.txt');
fid_pj = fopen('transf_pj.txt','w');
%for cnt_pj=1:size(transf_pj, 2)
for cnt_pj=1:size(assoc, 1)
	col_pj = transf_pj(:, cnt_pj);
	fprintf(fid_pj, "%f\t%f\n%f\t%f\n\n", col_pj(1), col_pj(2), col_pj(3), col_pj(4));
endfor

fclose(fid_pj);

printf("ASSOC\n");
%size(Li)
%size(Lj)
%assoc
delete('assoc_list.txt');
fid_assoc = fopen('assoc_list.txt', 'w');
%for ass_count=1:size(assoc, 1)
%	left_line = Li(7:10, assoc(ass_count,1));
%	right_line = Lj(7:10, assoc(ass_count,2));
for ass_count=1:size(Li, 2)
	left_line = Li(7:10, ass_count);
	right_line = Lj(7:10, ass_count);

	middle_point_i = 0.5*[left_line(1)+left_line(3) left_line(2)+left_line(4)];
	middle_point_j = 0.5*[right_line(1)+right_line(3) right_line(2)+right_line(4)];

	transf_mp_j = T*[middle_point_j'; 1];
	distance = [middle_point_i(1)-transf_mp_j(1) middle_point_i(2)-transf_mp_j(2)]*[middle_point_i(1)-transf_mp_j(1) middle_point_i(2)-transf_mp_j(2)]';
	%if(distance<max_dist_point)
		fprintf(fid_assoc, "%f\t%f\n%f\t%f\n\n", middle_point_i(1), middle_point_i(2), transf_mp_j(1), transf_mp_j(2));
	%endif
endfor
fclose(fid_assoc);

T;
printLines(Pj(7:10, :), 'Pj.txt', T);
printf("FATTO\n");

