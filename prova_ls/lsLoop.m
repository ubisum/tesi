function [xes,chis]=lsLoop(x,Z, iterations)
	xes=zeros(3,iterations);
	chis=zeros(1,iterations);
	xnew=x;
	for i=1:iterations
		[xnew,chiNew]=lsIteration(xnew,Z, .5, .5);
		%[xnew,chiNew]=lsIteration(xnew,Z, .006, .006);
		xes(:,i)=xnew;
		chis(1,i)=chiNew;
	end
endfunction
