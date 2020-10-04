clear all;
clc;

im = imread('LAKE.TIF');

qm = [16, 11, 10, 16, 24, 40, 51, 61;
    12, 12, 14, 19, 26, 58, 60, 55;
    14, 13, 16, 24, 40, 57, 69, 56;
    14, 17, 22, 29, 51, 87, 80, 62;
    18, 22 37, 56, 68, 109, 103, 77;
    24, 35, 55, 64, 81, 104, 113, 92;
    49, 64, 78, 87, 103, 121, 120, 101;
    72, 92, 95, 98, 112, 100, 103, 99];

c = 2;

im1 = im(420:427, 45:52);
im2 = im(427:434, 298:305);
im3 = im(30:37, 230:237);

im1 = double(im1);
im2 = double(im2);
im3 = double(im3);

F = create_mat_dct(8);

imDCT1 = myDCT(im1, F);
imDCT2 = myDCT(im2, F);
imDCT3 = myDCT(im3, F);

imq1 = myDCT_quantization(imDCT1, qm, c);
imq2 = myDCT_quantization(imDCT2, qm, c);
imq3 = myDCT_quantization(imDCT3, qm, c);

imdq1 = myDCT_dequantization(imq1, qm, c);
imdq2 = myDCT_dequantization(imq2, qm, c);
imdq3 = myDCT_dequantization(imq3, qm, c);

imr1 = myIDCT(imdq1, F);
imr2 = myIDCT(imdq2, F);
imr3 = myIDCT(imdq3, F);

subplot(2,3,1);
imshow(uint8(im1));
subplot(2,3,4);
imshow(uint8(imr1));

subplot(2,3,2);
imshow(uint8(im2));
subplot(2,3,5);
imshow(uint8(imr2));

subplot(2,3,3);
imshow(uint8(im3));
subplot(2,3,6);
imshow(uint8(imr3));

function a = myDCT(im, F)
    a = F*im;
    a = a*F';
end

function a = myDCT_quantization(imDCT, qm, c)
    qm = qm*c;
    a = imDCT./qm;
    a = round(a);
end

function a = myDCT_dequantization(imDCT, qm, c)
    qm = qm*c;
    a = imDCT.*qm;
end

function a = myIDCT(im, F)
    a = F'*im;
    a = a*F;
end
