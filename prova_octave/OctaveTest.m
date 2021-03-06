% generate a random set of points
#{
P = (rand(4,100)-.5)*100;
for i=1:size(P,2)
	n_i = P(3:4,i);
	n_i *= 1./norm(n_i);
	P(3:4,i) = n_i;
end
#}

P = readFromFile("convertedLines_0.txt");
%{
for i=1:size(P,2)
	n_i = P(3:4,i);
	n_i *= 1./norm(n_i);
	P(3:4,i) = n_i;
end
%}
% create a guess transform
%x_ideal=[20,30,pi/2]';
%x_ideal = [ 1.3635, 0, 0]';
x_ideal=[20,30,pi/4]';

% get the homogeneous matrix
X_ideal=v2t(x_ideal);

% obtain the transformed points (by column)
%Pt = transformPoints(inv(X_ideal),P);
%Pt = traslateLines(P, X_ideal);
%Pt = transformPoints(inv(X_ideal),Pt);

% assemble the measurement matrix
Z=zeros(8,size(P, 2));
Z(1:4,:)=P;
Z(5:8,:)=Pt;

% choose initial delta_x
x=[0,0,0]';

% run the algorithm and get the chi2
[xes, chis] = lsLoop(x,Z,100);
chis
xes

