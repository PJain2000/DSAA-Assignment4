clear all;
clc;

im = imread('cameraman.tif');
F = create_mat_dct(256);

im2 = dct2(im);

i1 = myIDCT(im2, F);
i2 = idct2(im2);

function a = myIDCT(im, F)
    a = F'*im;
    a = a*F;
end

