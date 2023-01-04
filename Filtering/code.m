%%  Take the input image and display it (Figure a)
I = imread('input.jpg');
fig = figure('WindowState','maximized');
subplot(2,4,1);
imshow(I);

I = im2double(I);

%% Zero padding
[row, col] = size(I);
R = zeros(row+2, col+2);
laplac_filtered = I;
sobel_filtered = I;
sobel_x = I;
sobel_y = I;

for i = 1:row
    for j = 1:col
        R(i+1, j+1) = I(i, j);
    end
end

%% Apply Laplacian Filter in image a (Figure b)
laplac_mask = [0 1 0;
               1 -4 1;
               0 1 0];

for i = 1:row
    for j = 1:col
        M = R(i:i+2, j:j+2);
        N = M.*laplac_mask;
        P = sum(N(:));
        laplac_filtered(i, j) = P;
    end
end

subplot(2,4,2);
imshow(laplac_filtered, []);

%%  Get the Laplacian Enhanced image (Figure c)
laplac_enhanced = I - laplac_filtered;

subplot(2,4,3);
imshow(laplac_enhanced);

%%  Apply Sobel Filter on image a (Figure d)
Gx = [1 0 -1;
     2 0 -2;
     1 0 -1];
 
Gy = [1 2 1;
     0 0 0;
    -1 -2 -1];

for i = 1:row
    for j = 1:col
        M = R(i:i+2, j:j+2);
        N = M.*Gx;
        P = sum(N(:));
        sobel_x(i, j) = P;
    end
end

for i = 1:row
    for j = 1:col
        M = R(i:i+2, j:j+2);
        N = M.*Gy;
        P = sum(N(:));
        sobel_y(i, j) = P;
    end
end

T = 0.01;

for i=1:row
    for j=1:col
        d = (sobel_x(i,j).^2 + sobel_y(i,j).^2).^0.5;
        if d>T
            sobel_filtered(i,j) = d;
        else
            sobel_filtered(i,j) = 0;
        end
    end
end

subplot(2,4,4);
imshow(sobel_filtered);

%%  Apply a 5X5 Average Filter Mask to image d (Figure e)
avg_mask =  (1/25)*ones(5);

[row, col] = size(sobel_filtered);
R = zeros(row+4, col+4);
avg_filtered = sobel_filtered;

for i = 1:row
    for j = 1:col
        R(i+2, j+2) = sobel_filtered(i, j);
    end
end

for i = 1:row
    for j = 1:col
        M = R(i:i+4, j:j+4);
        N = M.*avg_mask;
        P = sum(N(:));
        avg_filtered(i, j) = P;
    end
end
 
subplot(2,4,5);
imshow(avg_filtered);

%%  Get the product of image c and e (Figure f)
f = laplac_enhanced.*avg_filtered;

subplot(2,4,6);
imshow(f);

%%  Add image a and f (Figure g)
g = I + f;

subplot(2,4,7);
imshow(g);

%%  Apply Power Law Transform (Figure h)
c = 1;
Gamma = 0.5;
S = c*power(I(:,:),Gamma);

subplot(2,4,8);
imshow(S);

%%
           
