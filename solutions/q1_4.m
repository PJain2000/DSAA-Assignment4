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

count = 1;
arr = [1:10];
entropy_arr = [];
rmse_arr = [];

F = create_mat_dct(8);
im = double(im);

for c = 1:10
    func1 = @(block_struct) myDCT(block_struct.data, F);
    func2 = @(block_struct) myDCT_quantization(block_struct.data, qm, c);
    func3 = @(block_struct) myDCT_dequantization(block_struct.data, qm, c);
    func4 = @(block_struct) myIDCT(block_struct.data, F);

    B = blockproc(im,[8 8], func1);
    C = blockproc(B,[8 8], func2);
    D = blockproc(C,[8,8], func3);
    E = blockproc(D,[8 8], func4);
    entropy_arr(count) = My_entropy(E);
    rmse_arr(count) = RMSE(im, E);
    count = count + 1;
end

hold on;
subplot(2,1,1);
plot(arr, entropy_arr, '--rs')
title('Entropy vs compression factor')

subplot(2,1,2);
plot(arr, rmse_arr, '--rs')
title('RMSE vs compression factor')
hold off;


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

function e = RMSE(im1, im2)
    a = im1 - im2;
    a = a.^2;
    m = mean(a, 'all');
    e = sqrt(m);
end

function e = My_entropy(im)
    [p, ~] = imhist(im);
    p = p / numel(im);
    p(p == 0) = 1;
    e = -sum(p.*log2(p));
end