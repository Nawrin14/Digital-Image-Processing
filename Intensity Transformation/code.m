I = imread('input.jpg');

I = rgb2gray(I);

x = zeros(1,256);
[row, col] = size(I);

for i=1:row
    for j=1:col
        x(I(i,j) + 1)= x(I(i,j) + 1) + 1;
    end
end

R = im2double(I);

%%Power law transformation
Y = input('Enter gamma : ');
S = 1.5*power(R(:,:),Y);
S = im2uint8(S);

y = zeros(1,256);

for i=1:row
    for j=1:col
        y(S(i,j) + 1)= y(S(i,j) + 1) + 1;
    end
end

imwrite(S, 'Power law transformed image.jpg');

%%Threshold
S = I;
A = input('Enter threshold : ');
for i=1:row
    for j=1:col
        if I(i,j) <= A
            S(i,j) = I(i,j)+(I(i,j)*0.5);
        else
            S(i,j) = I(i,j)-(I(i,j)*0.25);
        end
    end
end

z = zeros(1,256);

for i=1:row
    for j=1:col
        z(S(i,j) + 1)= z(S(i,j) + 1) + 1;
    end
end

imwrite(S, 'Thresholded image.jpg');

%%Log transformation
S = 1.9*log(1+R(:,:));
S = im2uint8(S);

p = zeros(1,256);

for i=1:row
    for j=1:col
        p(S(i,j) + 1)= p(S(i,j) + 1) + 1;
    end
end

imwrite(S, 'Log transformed image.jpg');

%%Negation transformation
S = 255 - I(:,:);

q = zeros(1,256);

for i=1:row
    for j=1:col
        q(S(i,j) + 1)= q(S(i,j) + 1) + 1;
    end
end

imwrite(S, 'Negative image.jpg');

f = figure;
f.Position = [200 0 1000 1000];

subplot(3,2,1);
bar(x);
title('Histogram of the image');

subplot(3,2,2);
bar(y);
title('Histogram of the power law transformed image');

subplot(3,2,3);
bar(z);
title('Histogram of the thresholded image');

subplot(3,2,4);
bar(p);
title('Histogram of the log transformed image');

subplot(3,2,5);
bar(q);
title('Histogram of the negative image');
