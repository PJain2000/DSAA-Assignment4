clear all;
clc;

im = imread('cameraman.tif');

e = My_entropy(im);
f = entropy(im);
function e = My_entropy(im)
    [p, ~] = imhist(im);
    p = p / numel(im);
    p(p == 0) = 1;
    e = -sum(p.*log2(p));
end

