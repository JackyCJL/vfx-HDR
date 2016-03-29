# vfx-HDR
function hdr = vfx_hw1_hdr(file_path, lambda)
search for all .JPG or .png files in file_path and make hdr array.
if the files are of .png. the exposure value is specified in code.

the result of jpg file and hdr file is made with function makehdr(), tonemap().
