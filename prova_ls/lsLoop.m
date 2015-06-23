function [xes,chis]=lsLoop(x,Z, iterations)
	xes=zeros(3,iterations);
	chis=zeros(1,iterations);
	xnew=x;
	for i=1:iterations
		[xnew,chiNew]=lsIteration(xnew,Z, 0.5, 0.5);
		xes(:,i)=xnew;
		chis(1,i)=chiNew;
	end
endfunction
