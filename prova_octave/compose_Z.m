function Z = compose_Z(Li, Lj, assoc)

% prepare output
Z = zeros(8, size(assoc, 1));

% fill output 
for i=1:size(assoc, 1)
	assoc_row = assoc(i, :);
	Z(1:4, i) = Li(assoc_row(1));
	Z(5:8, i) = Lj(assoc_row(2));
endfor

endfunction
