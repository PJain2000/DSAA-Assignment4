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

F = create_mat_dct(8);
im = double(im);

func1 = @(block_struct) myDCT(block_struct.data, F);
func2 = @(block_struct) myDCT_quantization(block_struct.data, qm, c);

B = blockproc(im,[8 8], func1);
C = blockproc(B,[8 8], func2);

% imshow(uint8(C));

function a = myDCT(im, F)
    a = F*im;
    a = a*F';
end

function a = myDCT_quantization(imDCT, qm, c)
    qm = qm*c;
    a = imDCT./qm;
    a = round(a);
end
