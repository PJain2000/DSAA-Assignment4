clear all;
clc;

im = imread('cameraman.tif');
F = create_mat_dct(256);

i1 = myDCT(double(im), F);
i2 = dct2(im);

function a = myDCT(im, F)
    a = F*im;
    a = a*F';
end

