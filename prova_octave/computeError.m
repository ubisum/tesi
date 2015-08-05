function e=computeError(i,X,Z)
  e=transformPoints(X,Z(5:8,i)) - Z(1:4,i);
endfunction
