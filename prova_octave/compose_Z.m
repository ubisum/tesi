function Z = compose_Z(Li, Lj, assoc)
%size(Li)
%size(Lj)
%size(assoc)
% prepare output
Z = zeros(8, size(assoc, 1));

% fill output 
%size(Li)
%size(Lj)
%size(assoc)
%assoc
for i=1:size(assoc, 1)
	assoc_row = assoc(i, :);
	%assoc_row(2);
	Z(1:4, i) = Li(1:4, assoc_row(1));
	Z(5:8, i) = Lj(1:4, assoc_row(2));
endfor

endfunction
