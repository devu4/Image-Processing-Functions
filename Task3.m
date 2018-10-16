% MATLAB script for Assessment Item-1
% Task-3
clear; close all; clc;

% Step-1: Load input image
Img = imread('Noisy.png');
figure;
imshow(Img);
title('Step-1: Load Noisy image');

% Step-2: Conversion of input image to grey-scale image
I = rgb2gray(Img);
I = im2double(I);
figure;
imshow(I);
title('Step-2: Conversion of input image to greyscale');

% Step-3: Zero Pad the image to account for boundary pixels
I = padarray(I,[2 2]);
figure; imshow(I); title('Step-3: Zero Pad the Image');

% Create a normalized 5-by-5 pixel averaging filter
f = ones(5 , 5)/ 25 ;

% Step-4: Loop through matrix and apply filer on 5x5 neighbourhood and sum to find average.
s = size(I); % get size of original
r = zeros(s); % make matrix of size original with zeros
for i = 3:s(1)-2 % Don't want to loop through padded pixels as it is not needed
    for j = 3:s(2)-2 % Don't want to loop through padded pixels as it is not needed
        temp = I(i-2:i+2,j-2:j+2) .* f; % Apply filter to divide 25
        r(i,j) = sum(temp(:)); % sum values and set to new matrix
    end
end
r = r(3:end-2, 3:end-2); % remove zero padding on output image
figure; imshow(r); title('Step-4: Output Image via Average Filter');

% Step-5: Loop through matrix and find median and set to output matrix.
r = zeros(s); % make matrix of size original with zeros
for i = 3:s(1)-2 % Don't want to loop through padding pixels as it is not needed
    for j = 3:s(2)-2 % Don't want to loop through padded pixels as it is not needed
        temp = I(i-2:i+2,j-2:j+2); % get 5x5 neighbour matrix
        temp1 = median(temp(:)); % find the median of all values in matrix
        r(i,j) = temp1; % set median value to output matix
    end
end
r = r(3:end-2, 3:end-2); % remove zero padding on output image
figure; imshow(r); title('Step-5: Output Image via Median Filter');
