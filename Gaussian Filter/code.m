%Gaussian filter with kernel size 5X5 

I = imread('input.png');

sigma = input('Enter the sigma value: ');

[row, col] = size(I);
R = uint8(zeros(row+4, col+4));
S = uint8(zeros(row+4, col+4));

for i = 1:row
    for j = 1:col
        R(i+2, j+2) = I(i, j);
    end
end

X = [-2 -1 0 1 2;
    -2 -1 0 1 2;
    -2 -1 0 1 2;
    -2 -1 0 1 2;
    -2 -1 0 1 2];

Y = X';

a = -(X.^2 + Y.^2) / (2*sigma*sigma);

kernel = exp(a)./(2*pi*sigma*sigma);

for i = 1:row
    for j = 1:col
        M = R(i:i+4, j:j+4);
        N = double(M).*kernel;
        b = sum(N(:));
        S(i+2, j+2) = b;
    end
end

P = S(3:row+2, 3:col+2);

figure;
subplot(1,2,1);
imshow(I);
title('Input');

subplot(1,2,2);
imshow(P);
title('Output');

imwrite(P, 'output.jpg');
