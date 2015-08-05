function points_T = applyT(points, T)

points_T = [];

point_up = T*[points(1:2,:); ones(1, size(points,2))];
point_dw = T*[points(3:4,:); ones(1, size(points,2))];

%point_up = T(1:2, 1:2)*points(1:2,:) + repmat(T(1:2,3), 1, size(points,2));
%point_dw = T(1:2, 1:2)*points(3:4,:) + repmat(T(1:2,3), 1, size(points,2));

points_T = [point_up(1:2,:); point_dw(1:2, :)];
endfunction
