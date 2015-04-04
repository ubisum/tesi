function dist = computeDistanceRT(Li, Lj, T)

% prepare output
dist = zeros(size(Li, 2), size(Lj, 2));

% transform lines
Lj_transf = transformRT(Lj, t2v(T));

% compute distances
for i=1:size(Li, 2)

	% select vector i
	vec_i = Li(:, i);

	for j=1:size(Lj, 2)

		% select vector j
		vec_j = Lj_transf(:, j);

		% distance
		diff_ij = vec_i-vec_j;
		dist(i, j) = diff_ij'*diff_ij;

	endfor
endfor

endfunction
