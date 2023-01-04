%Create the flipped image of an image and merge the two images

I = imread('input.png');
figure; 
imshow(I);

flipped = I(:, end:-1:1 ,:);
figure;
imshow(flipped);

%original_grayscale = rgb2gray(I);
%flipped_grayscale = rgb2gray(flipped);

[row, col, dep] = size(I);
merged = uint8(ones(row, col, dep));
merged(:, 1:col, :) = I(:,:,:);
merged(:, col+1:2*col, :) = flipped(:,:,:);
figure; 
imshow(merged);

imwrite(merged, 'output.jpg');
