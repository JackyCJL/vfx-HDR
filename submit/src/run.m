exp_time = [1/0.03125, 1/0.0625, 1/0.125, 1/0.25, 1/0.5, 1/1, 1/2, 1/4, 1/8, 1/16, 1/32, 1/64, 1/128, 1/256, 1/512, 1/1024 ];
[hdrImg, g] = hdr('../data/image_series/Memorial_SourceImages/', exp_time, 50);
hdrwrite(hdrImg,'../data/result/Memorial.hdr');
resultImg = reinhardTM(hdrImg,false);
resultImg = im2uint8(resultImg);
imwrite(resultImg,'../data/result/tonemapping_Memorial_global.jpg');
resultImg = reinhardTM(hdrImg);
resultImg = im2uint8(resultImg);
imwrite(resultImg,'../data/result/tonemapping_Memorial_local.jpg');

series1_exp_time = [4.56599286563615, 0.00632098765432099 ,0.00158024691358025, 1.97530864197531, 2, 2.04800000000000 ,1.26419753086420 ,0.316049382716049 ,0.158024691358025 ,0.0632098765432099 ,0.0197530864197531];
[hdrImg, g] = hdr('../data/image_series/series1', series1_exp_time, 50);
hdrwrite(hdrImg,'../data/result/series1.hdr');
resultImg = reinhardTM(hdrImg,false);
resultImg = im2uint8(resultImg);
imwrite(resultImg,'../data/result/tonemapping_series1_global.jpg');
resultImg = reinhardTM(hdrImg);
resultImg = im2uint8(resultImg);
imwrite(resultImg,'../data/result/tonemapping_series1_local.jpg');

series2_exp_time = [0.0125000000000000, 2.04800000000000, 6.14400000000000, 0.0320000000000000, 0.0800000000000000, 0.133333333333333, 0.200000000000000, 0.533333333333333, 0.853333333333333, 1, 1.05785123966942];
[hdrImg, g] = hdr('../data/image_series/series2', series2_exp_time, 50);
hdrwrite(hdrImg,'../data/result/series2.hdr');
resultImg = reinhardTM(hdrImg,false);
resultImg = im2uint8(resultImg);
imwrite(resultImg,'../data/result/tonemapping_series2_global.jpg');
resultImg = reinhardTM(hdrImg);
resultImg = im2uint8(resultImg);
imwrite(resultImg,'../data/result/tonemapping_series2_local.jpg');


series3_exp_time = [6.14400000000000, 0.00200000000000000, 2.04800000000000, 0.757396449704142, 0.816326530612245, 0.400000000000000, 0.200000000000000, 0.0800000000000000, 0.0320000000000000, 0.00800000000000000];
[hdrImg, g] = hdr('../data/image_series/series3', series3_exp_time, 50);
hdrwrite(hdrImg,'../data/result/series3.hdr');
resultImg = reinhardTM(hdrImg,false);
resultImg = im2uint8(resultImg);
imwrite(resultImg,'../data/result/tonemapping_series3_global.jpg');
resultImg = reinhardTM(hdrImg);
resultImg = im2uint8(resultImg);
imwrite(resultImg,'../data/result/tonemapping_series3_local.jpg');

series4_exp_time = [6.14400000000000, 0.0400000000000000, 0.0200000000000000, 0.0100000000000000, 0.00500000000000000, 0.00200000000000000, 3.07200000000000, 1.22880000000000, 1.05785123966942, 1.02040816326531, 1, 0.400000000000000, 0.200000000000000, 0.100000000000000];
[hdrImg, g] = hdr('../data/image_series/series4', series4_exp_time, 50);
hdrwrite(hdrImg,'../data/result/series4.hdr');
resultImg = reinhardTM(hdrImg,false);
resultImg = im2uint8(resultImg);
imwrite(resultImg,'../data/result/tonemapping_series4_global.jpg');
resultImg = reinhardTM(hdrImg);
resultImg = im2uint8(resultImg);
imwrite(resultImg,'../data/result/tonemapping_series4_local.jpg');