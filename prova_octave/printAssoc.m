function printAssoc(Li, Lj, T, file_name)

delete(file_name);
fid_assoc = fopen(file_name, 'w')

for ass_count=1:size(Li, 2)
	left_line = Li(7:10, ass_count);
	right_line = Lj(7:10, ass_count);
	

	middle_point_i = 0.5*[left_line(1)+left_line(3) left_line(2)+left_line(4)];
	middle_point_j = 0.5*[right_line(1)+right_line(3) right_line(2)+right_line(4)];

	transf_mp_j = T*[middle_point_j'; 1];
	%distance = [middle_point_i(1)-transf_mp_j(1) middle_point_i(2)-transf_mp_j(2)]*[middle_point_i(1)-transf_mp_j(1) middle_point_i(2)-transf_mp_j(2)]';
	%if(distance<max_dist_point)
		fprintf(fid_assoc, "%f\t%f\n%f\t%f\n\n", middle_point_i(1), middle_point_i(2), transf_mp_j(1), transf_mp_j(2));
	%endif
endfor
fclose(fid_assoc);

endfunction
