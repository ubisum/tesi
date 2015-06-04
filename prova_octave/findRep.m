function rep = findRep(assoc)

copy_assoc = [assoc(:, 2) zeros(size(assoc,1), 1)]
%size(copy_assoc)
rep = {};

for i=1:size(copy_assoc, 1)
	if(copy_assoc(i, 2) == 0)
		inds = find(copy_assoc == copy_assoc(i, 1));

		if(size(inds, 1) > 1)
			if(size(rep,1) == 0)
				rep{1,1} = inds;
			else
				rep = {rep inds};
			endif
		endif
	copy_assoc(inds, 2) = 1;
	endif
endfor

copy_assoc
endfunction
