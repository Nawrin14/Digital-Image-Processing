%%Contrast streching

I = imread('input.png');

[row, col] = size(I);

R = zeros(row,col);
A = double(min(I(:)));
B = double(max(I(:)));
D = B - A;
M = 2.^8-1;

for i=1:row
    for j=1:col
        R(i,j) = (((double(I(i,j))-A)/D) * M) + A;
    end
end

R = uint8(R);

x = zeros(1,256);

for i=1:row
    for j=1:col
        x(I(i,j) + 1)= x(I(i,j) + 1) + 1;
    end
end

y = zeros(1,256);
[row, col] = size(R);

for i=1:row
    for j=1:col
        y(R(i,j) + 1)= y(R(i,j) + 1) + 1;
    end
end

subplot(2,2,1);
imshow(I);
title('Input image');

subplot(2,2,2);
imshow(R);
title('Output image');

subplot(2,2,3);
bar(x);
title('Histogram of input image');

subplot(2,2,4);
bar(y);
title('Histogram of output image');

imwrite(R, 'output.jpg');
