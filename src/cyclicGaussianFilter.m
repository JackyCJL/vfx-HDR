function imgOut=cyclicGaussianFilter(imgIn,kernelHalfRange)

[ x , y ] = meshgrid( -kernelHalfRange : kernelHalfRange , -kernelHalfRange : kernelHalfRange );
h = 1 / ( pi * ( alpha1 * i ) ^ 2 ) .* exp( - ( x .^ 2 + y .^ 2)  / ( alpha1 * i ) ^ 2 );
imgOut = imfilter(imgIn,h,'symmetric');