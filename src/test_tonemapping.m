img = hdrread('../data/hdr/tahoe1.hdr');
resultImg = reinhardTM(img,false);
resultImg = im2uint8(resultImg);
imwrite(resultImg,'../data/test_tonemapping_global.jpg');
resultImg = reinhardTM(img);
resultImg = im2uint8(resultImg);
imwrite(resultImg,'../data/test_tonemapping_local.jpg');
