img = hdrread('../data/result/Memorial.hdr');
resultImg = reinhardTM(img);
resultImg = im2uint8(resultImg);
imwrite(resultImg,'../data/test_tonemapping_global.jpg');
resultImg = reinhardTM(img,true);
resultImg = im2uint8(resultImg);
imwrite(resultImg,'../data/test_tonemapping_local.jpg');
