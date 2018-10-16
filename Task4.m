% MATLAB script for Assessment Item-1
% Task-4
clear; close all; clc;

% Step-1: Load input image
Img = imread('Starfish.jpg');
figure; imshow(Img); title('Step-1: Load Starfish image');

% Step-2: Conversion of input image to grey-scale image
I = rgb2gray(Img);
figure; imshow(I); title('Step-2: Grey-Scale Image'); 
 
% Step-3: Do a median filter to get rid of noise using 5x5 kernal mask
I = medfilt2(I, [5 5]);
figure;imshow(I); title('Step-3: Median Filtered Image');

% Step-4: Make binary image by thresholding image
I = imbinarize(I,0.9);
figure; imshow(I); title('Step-4: Binary Image by thresholding');

%https://uk.mathworks.com/matlabcentral/answers/195257-how-can-i-detect-round-objects-and-remove-other-objects-in-an-image-using-matlab
% Step-5: Make blobs out of objects in binary image
labeledImage = bwlabel(~I);% make blobs of all objects in image, we ~I as we want objects to be white and not black
stats = regionprops(labeledImage,'Area','Perimeter');% get area and permeter properties of each object
figure; imshow(labeledImage); title('Step-5: Blobs from objects');

% Get areas and perimeters of all the blobs into single arrays.
allAreas = [stats.Area];
allPerimeters = [stats.Perimeter];
% Compute roundness of all blobs using area and perimeter.
roundness = (4*pi*allAreas)./allPerimeters.^2;
% Find the starfish objects and get rid of everything else
starFishObjects = find(allAreas > 1020 & roundness > 0.2 & roundness < 0.3);
% Compute new binary image with only the star fish objects in it using the regions found above.
binaryImage = ismember(labeledImage, starFishObjects) > 0;
figure; imshow(binaryImage); title('Step-6: Final Image with all found Star fish');
