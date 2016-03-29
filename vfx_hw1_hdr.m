function hdr = vfx_hw1_hdr(file_path, lambda)
    rgb = {};
    files_1 = dir([file_path '\*.JPG']);
    files_2 = dir([file_path '\*.png']);
    use_jpg = 1;
    if size(files_1, 1) > 0
       files = files_1;
    else
       files = files_2;
       use_jpg = 0;
    end
    
    exp_time = [];
    file_names = {};
    for i = 1:size(files,1)   
        file_names(i) = {[file_path '\' files(i).name]};
        rgb(i) = {imread([file_path '\' files(i).name])};
        iminfo = imfinfo([file_path '\' files(i).name]);
        if use_jpg == 1 
            exp_time(i) = iminfo.DigitalCamera.ExposureTime;
        end
    end
    [row,col,color_n] =  size(rgb{1});
    if use_jpg == 0
        exp_time = [1/0.03125, 1/0.0625, 1/0.125, 1/0.25, 1/0.5, 1/1, 1/2, 1/4, 1/8, 1/16, 1/32, 1/64, 1/128, 1/256, 1/512, 1/1024 ];
    end
    log_time = [];
    for i = 1:size(files,1)
        log_time(i) = log(exp_time(i));    
    end 
    picture = size(files,1);
    [g, lE]  = calculate_g(row, col, picture, lambda, rgb, log_time);
    hdr = zeros(row,col,color_n);
    for color = 1:color_n
        for i = 1:row
            for j = 1:col
                hdr(i,j,color) = exp( g(rgb{ceil(picture/2)}(i,j,color)-log_time(ceil(picture/2))) );
            end
        end
    end
end

function [g, lE]  = calculate_g(row, col, picture, lambda, rgb, log_time)
   
    color_n=3;
    pixels = row*col;
    z_bool = zeros(1,row*col);
    z_vector = []; 
    i = 1;
    sample_n = 100;
    n = 256;
 
    while i <= sample_n
        sample = ceil(rand()*pixels);
        if z_bool(1,sample) == 1;
            continue
        else
            z_bool(1,sample) = 1;
            z_vector(i) = sample;
            i = i + 1;            
        end
    end
    for color = 1:color_n
        z = zeros(sample_n,picture);
        for i = 1:sample_n
            for p = 1:picture
                r = ceil(z_vector(i)/col);
                c = z_vector(i) - (r-1)*col;
                z(i,p) = rgb{p}(r,c,color);
            end
        end
        n = 256;
        A = zeros(size(z,1)*size(z,2)+n-1, n+size(z,1));
        b = zeros(size(A,1),1);
        k = 1;
        for i=1:size(z,1)
            for j=1:size(z,2)
                wij = weight(z(i,j)+1);
                A(k,z(i,j)+1) = wij;
                A(k,n+i) = -wij;
                b(k,1) = wij*log_time(j);
                k=k+1;
            end
        end
        A(k,129) = 1;
        k=k+1;
        for i=1:n-2
            A(k,i)=lambda*weight(i+1);
            A(k,i+1)=-2*lambda*weight(i+1);
            A(k,i+2)=lambda*weight(i+1);
            k=k+1;
        end
        x = A\b;
        g = x(1:n);
        lE = x(n+1:size(x,1));
    end
end

function w = weight(z)
    zmin = 1;
    zmax = 256;
    average = (zmin+zmax)/2;
    if z >= average
        w = zmax - z;
    else
        w = z - zmin;
    end
end
    
function out = fibo(n)
    if n==1
        out=0;
        return;
    elseif n==2
        out=1;
        return;
    else
        out=fibo(n-1)+fibo(n-2);
    end
end
    