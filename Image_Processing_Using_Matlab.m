% Made by Azaz Hassan Khan || 18jzele0262 || LAB 11
 
clear
close all
clc
 
% Loading the images in Matlab
 
Pic_1 = imread('picture1.jpeg');     % Read the first image
Pic_2 = imread('picture2.jpeg');     % Read the second image
 
figure
subplot(1,2,1)                    % subplot
imshow(Pic_1)                     % to show the pic
title('Picture # 01')             % title of the pic
 
subplot(1,2,2)
imshow(Pic_2)                     % to show the pic
title('Picture # 02')             % title of the pic
 
% Finding the differences between the two images
 
Pic_diff_1 = Pic_2 - Pic_1;     % Find the difference between the images
Pic_diff_2 = Pic_1 - Pic_2;     % Find the difference between the images
 
figure
subplot(1,2,1)
imshow(Pic_diff_1)
title('Difference between Pic 1 and Pic 2')
 
subplot(1,2,2)
imshow(Pic_diff_1)
title('Difference between Pic 2 and Pic 1')
 
[M1, N1, P1] = size(Pic_1);     % Get the pixel count in the picture
 
for ii = 1:M1           % Counter for the pixels in the horizental direction
    
    for jj = 1:N1       % Counter for the pixels in the vertical direction
    
        for kk = 1:P1   % Counter for the pixels in the R, B and G
            
            if Pic_diff_1(ii,jj,kk) <= 40   % Check if the pixel has black color
 
                Pic_diff_1(ii,jj,kk) = 255; % If pixel is black, convert it to white
 
            end
 
            if Pic_diff_2(ii,jj,kk) <= 40   % Check if the pixel has black color
 
                Pic_diff_2(ii,jj,kk) = 255; % If pixel is black, convert it to white
 
            end
        
        end
        
    end
end
 
% Viewing the resulting images
figure
subplot(1,2,1)
imshow(Pic_diff_1)
 
subplot(1,2,2)
imshow(Pic_diff_2)
