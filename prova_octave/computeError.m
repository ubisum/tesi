function e=computeError(i,X,Z)
  pi=ones(4,1);
  pj=ones(4,1);
  pi(1:4)=Z(1:4,i);
  pj(1:4)=Z(5:8,i);
  efull = transformPoints(X,pj) - pi;
  e=efull(1:4);
endfunction
