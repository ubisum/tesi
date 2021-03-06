function transRT = transformRT(L, v)

% local data
x = v(1);
y = v(2);
theta = v(3);

% prepare output
transRT = zeros(size(L));

% transform
for i=1:size(L, 2)
	% select a line
	line_ith = L(:, i);
	rho_ith = line_ith(1);
	theta_ith = line_ith(2);

	% compute transformation
	transRT(2,i) = theta_ith + theta;
	transRT(1,i) = rho_ith + cos(transRT(2,i))*x + sin(transRT(2,i))*y;
endfor

endfunction
