function Z=finterpHtoL(A,X)
	% A -- original data
	% X -- times
	[nx,ny] = size(A);
	X2 = X*X;
	A = reshape(A,nx,X,ny/X);
	A = permute(A,[2,1,3]);
	A = reshape(A,X2,nx*ny/X2);
	mask = ~isnan(A);
	mask = sum(mask);
	mask(mask<(X2/2))=nan;
	A = nanmean(A);
	A(isnan(mask))=nan;
	Z = reshape(A,nx/X,ny/X);
return