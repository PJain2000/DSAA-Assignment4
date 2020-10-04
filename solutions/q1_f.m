clear all;
clc;

im1 = randi(8, 8);
im2 = randi(8, 8);

e = RMSE(im1, im2);
function e = RMSE(im1, im2)
    a = im1 - im2;
    a = a.^2;
    m = mean(a, 'all');
    e = sqrt(m);
end