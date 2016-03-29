function [hdr, g] = vfx_hw1_hdr(file_path, lambda)
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
                    g_sum = double(0);
                    w_sum = double(0);
                    for p = 1:picture
                        g_sum = g_sum+ weight(rgb{p}(i,j,color))*(g(color,rgb{p}(i,j,color)+1)-log_time(p));
                        w_sum = w_sum + weight(rgb{p}(i,j,color)); 
                    end
                    if w_sum == 0
                        hdr(i,j,color) = 0;
                    else
                        hdr(i,j,color) = exp(g_sum/w_sum);
                    end
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
    g = zeros(3,n);
    n_sq = ceil(sqrt(sample_n));
    k=1;
    for i = 1:n_sq
        for j = 1:n_sq
            z_vector(k) = i*floor(row/n_sq)*col + j*floor(col/n_sq);
            k = k+1;
            if k > 100
                break
            end
        end
        if k > 100
            break
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
        g(color,1:n) = x(1:n);
        lE = x(n+1:size(x,1));
    end
    z = 0:1:255;
    y1 = g(1,z+1);
    y2 = g(2,z+1);
    y3 = g(3,z+1);
    plot(y1,z,y2,z,y3,z);
end

function w = weight(z)
    zmin = 0;
    zmax = 255;
    average = (zmin+zmax)/2;
    if z >= average
        w = double(zmax - z);
    else
        w = double(z - zmin);
    end
end
    