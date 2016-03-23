function imgOut = reinhardTM(imgIn,isLocalTM,key,delta,white,gamma,threshold,phi,num,low,high)

if(~exist('isLocalTM)','var'))
	isLocalTM=true;
end

if(~exist('key','var'))
	key = 0.18;
end

if(~exist('delta','var'))
	delta = 1e-6;
end

if(~exist('white','var'))
	white = 1e20;
end

if(~exist('gamma','var'))
	gamma = 1.6;
end

if(~exist('threshold','var'))
	threshold = 0.05;
end

if(~exist('phi','var'))
	phi = 8;
end

if(~exist('num','var'))
	num = 8;
end

if(~exist('low','var'))
	low = 1;
end

if(~exist('high','var'))
	high = 43;
end

R = imgIn(:,:,1);
G = imgIn(:,:,2);
B = imgIn(:,:,3);
imgIn =  0.299*R + 0.587*G + 0.114*B;

Lw = exp( mean( mean( log( delta + imgIn ) ) ) );
L = key / Lw .* imgIn;


if(isLocalTM)
	alpha = 1;
	kernelHalfRange = alpha * 5;
	V1 = cyclicGaussianFilter(L,alpha,kernelHalfRange);
	alpha = alpha * 1.6;
	kernelHalfRange = alpha * 5;
	V2 = cyclicGaussianFilter(L,alpha,kernelHalfRange);
	V(:,:,1) = ( V1 - V2 ) ./ ( 2^phi + V1);
	for i = 2 : ( num - 1 )
		alpha = alpha * 1.6;
		V1 = V2;
		kernelHalfRange = alpha * 5;
		V2 = cyclicGaussianFilter(L,alpha,kernelHalfRange);
		V(:,:,i) = ( V1 - V2 ) ./ ( 2^phi + V1);
	end
	V(:,:,num) = V2;
	[ h , w , ~] = size(V);
	Ld = zeros(h,w);
	for i = 1: h
		for j = 1 : w
			for k = 1 : ( num - 1 )
				if abs( V(i,j,k) ) < threshold
					for s = k : num;
						Ld(i,j) = Ld(i,j) + V(i,j,s);
					end
					break;
				end
			end
		end
	end
	Ld = L ./ ( Ld + 1 );
else
	Ld = L ./ ( 1 + L );
end

imgOut(:,:,1) = R ./ imgIn .* Ld;
imgOut(:,:,2) = G ./ imgIn .* Ld;
imgOut(:,:,3) = B ./ imgIn .* Ld;
for i = 1 : 3
	imgOut(:,:,i) = imgOut(:,:,i) .^ (1/gamma);
end
