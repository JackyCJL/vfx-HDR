function imgOut=cyclicGaussianFilter(imgIn,alpha,kernelHalfRange)

[ x , y ] = meshgrid( -kernelHalfRange : kernelHalfRange , -kernelHalfRange : kernelHalfRange );
h = 1 / ( pi * alpha ^ 2 ) .* exp( - ( x .^ 2 + y .^ 2)  / ( alpha ^ 2 ) );
imgOut = imfilter(imgIn,h,'symmetric');
