function data = traslateLines(P, tras_mat)
	
	% temp data
	temp_data = zeros(3, size(P, 2));
	temp_data(1:2, :) = P(1:2, :);
	temp_data(3, :) = ones(1, size(P, 2));
	#{
	% random traslations
	random_tr_x = rand(1,1)*10;
	random_tr_y = rand(1,1)*10;

	% compose a traslation matrix
	tras_mat = zeros(3,3);
	tras_mat(1:2, 1:2) = eye(2, 2);
	tras_mat(1:3, 3) = [random_tr_x random_tr_y 1]';
	#}
	for i=1:size(P, 2)
		% rotate line
		temp_data(:, i) = tras_mat*temp_data(:, i);
	endfor

	% fill output
	data = zeros(4, size(P, 2));
	data(1:2, :) = temp_data(1:2, :);
	data(3:4, :) = P(3:4, :);

endfunction

