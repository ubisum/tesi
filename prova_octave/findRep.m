function rep = findRep(assoc)

copy_assoc = assoc;
%size(copy_assoc)
rep = {};

while(size(copy_assoc, 2) > 0)
	%printf("DENTRO\n");
	elem = copy_assoc(1);
	indeces = find(copy_assoc == elem);

	for i=1:size(indeces, 1)
		copy_assoc(i) = [];
	endfor

	if(size(indeces, 1) > 1)
		if(size(rep, 1) == 0)
			rep{1, 1} = indeces;
		else
			rep = {rep indeces};
		endif
	endif
	%size(copy_assoc)
	%copy_assoc;
endwhile

endfunction
