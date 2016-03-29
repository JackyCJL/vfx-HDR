[hdrImg, g] = hdr('../data/image_series/Memorial_SourceImages/', 50);
hdrwrite(hdrImg,'../data/test.hdr');
resultImg = reinhardTM(hdrImg,false);
resultImg = im2uint8(resultImg);
imwrite(resultImg,'../data/test_tonemapping_global2.jpg');
resultImg = reinhardTM(hdrImg);
resultImg = im2uint8(resultImg);
imwrite(resultImg,'../data/test_tonemapping_local2.jpg');