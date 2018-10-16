% MATLAB script for Assessment Item-1
% Task-1
clear; close all; clc;

% Step-1: Load input image
Img = imread('Zebra.jpg');
figure; imshow(Img); title('Step-1: Load input image');

% Step-2: Conversion of input image to grey-scale image
I = rgb2gray(Img);
figure; imshow(I); title('Step-2: Conversion of input image to greyscale');
 
% Step-3: Use nearestNeighbour interpolation to resize image
% Nearest Neighbout function is explained in the function at end of this file
out = nearestNeighbour(1668, 1836, I);
figure; subplot(1,2,1); imagesc(out);colormap gray; title('Step-3: Output Image using Nearest Neighbour Interpolation');

% Step-4: Use bilinear interpolation to resize image
% bilinearInterpolation function is explained in the function at end of this file
out = bilinearInterpolation(1668, 1836, I);
subplot(1,2,2); imagesc(out);colormap gray; title('Step-4: Output Image using Bilinear Interpolation');

% Using help from https://www.giassa.net/?page_id=207
function [out] = nearestNeighbour(x,y, Org) % x = new image height, y = new image width, Org = old image matrix
    %Find original image size 
    [j , k] = size(Org);
    %Find scale of image resize, used later to map new pixels to old image
    x_scale = x/(j-1); % we minus 1 due to how arrays are accessed in matlab, stops going out of array
    y_scale = y/(k-1);
    %Declare and initialize an output image matrix using new size required
    out = zeros(x, y);
    %Loop through output matrix and populate using intensity from original images nearest neighbour intensity
    for count1 = 0:x-1
     for count2 = 0:y-1
         out(count1+1,count2+1) = Org(1+round(count1/x_scale),1+round(count2/y_scale));
         % Output pixel will equal the pixel mapped to original image
         % round is used to find the nearest neighbour pixel
         % Uses scale to map pixels to original image.
     end
    end

end %end of function

% Using help from https://www.giassa.net/?page_id=240
function out = bilinearInterpolation(x, y, I )
 
s = size(I);

%Determine the ratio of the old dimensions compared to the new dimensions 
x_scale = x./(s(1)-1);
y_scale = y./(s(2)-1);

%Declare and initialize an output image buffer
out = zeros(x, y);

%Generate the output image
    for i = 0:x-1
     for j = 0:y-1
         
         W = -(((i./x_scale)-floor(i./x_scale))-1); %  get distance to pixel being calculated in x
         H = -(((j./y_scale)-floor(j./y_scale))-1); %  get distance to pixel being calculated in Y
         
         A = I(1+floor(i./x_scale),1+floor(j./y_scale)); % Get all four nearest neighbours to the pixel being assessed
         B = I(1+ceil(i./x_scale),1+floor(j./y_scale));
         c = I(1+floor(i./x_scale),1+ceil(j./y_scale));
         D = I(1+ceil(i./x_scale),1+ceil(j./y_scale));
         
         %formula used to work out weighted average of neighbour pixels values
         out(i+1,j+1) = (1-W).*(1-H).*D + (W).*(1-H).*c + (1-W).*(H).*B + (W).*(H).*A;
     end
    end
end