function printLines(lines_list, file_name, T)
	delete(file_name);
	fid_assoc = fopen(file_name, 'w');
	for i=1:size(lines_list, 2)
		col = lines_list(:, i);
		up_col = T*[col(1:2,:); 1];
		lw_col = T*[col(3:4,:); 1];	
		%up_col = T(1:2, 1:2)*col(1:2, :) + T(1:2,3);
		%lw_col = T(1:2, 1:2)*col(3:4, :) + T(1:2,3);
		fprintf(fid_assoc, "%f\t%f\n%f\t%f\n\n", up_col(1), up_col(2), lw_col(1), lw_col(2));
	endfor
	fclose(fid_assoc);
endfunction
