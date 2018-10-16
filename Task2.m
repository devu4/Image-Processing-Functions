% MATLAB script for Assessment Item-1
% Task-2
clear; close all; clc;

% Step-1: Load input image
I = imread('SC.png');
figure;
imshow(I);
title('Step-1: Input Image');

% Step-2: Logical method to find vector elements between 80 & 100 and change them to 220
I(I >= 80 & I <=100) = 220; % Implementing the Piecewise-Linear transformation function

% Display transformed Image
figure;
imshow(I);
title('Step-2: Output Image');