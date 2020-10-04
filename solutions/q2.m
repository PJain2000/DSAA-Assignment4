d = dir ("../dataset");
a = []

for i = 1:520
    a(:,i) = flat(im2double(imread(strcat(d(i+2).folder, "/", d(i+2).name))));
end

covm = a'*a;
[eigv, eigd] = eig(covm);

eigd = sum(eigd);
[eigd, x] = sort(eigd, 'descend');
x = x(1:35);
F = eigv(:,x);

s = mrdivide(a, F');
res = F*s';
res = res';

image = reshape (res(:,500), 256, 256, 3);
% imshow(image);

mat = F' * a';

scatter (mat (1,:) * a, zeros(1,520));
scatter (mat (1,:) * a, mat (2,:) * a);
scatter3 (mat (1,:) * a, mat (2,:) * a, mat (3,:) * a);

function out = flat(image)
	t = double(rgb2gray(image));
	[testm, testn] = size(t);
	size_new = testm*testn*3;
	out = reshape(image, size_new, 1);
end
