% Load image
img_with_rectangle = img = imread('A3_image.png');

% Split image-channels into grayscale images
red_img_with_rectangle = red_img = img(:,:,1);
green_img_with_rectangle = green_img = img(:,:,2);
blue_img_with_rectangle = blue_img = img(:,:,3);

% Make a black rectangle by setting values in its range to 0
% Note that the "image coordinate system" is luckily in the upper left corner already
img_with_rectangle(1:100,1:100,:) = 0;
red_img_with_rectangle(1:100,1:100) = 0;
green_img_with_rectangle(1:100,1:100) = 0;
blue_img_with_rectangle(1:100,1:100) = 0;

%Plot each image with and without a black rectangle
figure(1);

subplot(2,4,1);
imshow(img);
title("Image used");

subplot(2,4,2);
imshow(red_img);
title("Red channel");

subplot(2,4,3);
imshow(green_img);
title("Green channel");

subplot(2,4,4);
imshow(blue_img);
title("Blue channel");

subplot(2,4,5);
imshow(img_with_rectangle);
title("Image with rectangle");

subplot(2,4,6);
imshow(red_img_with_rectangle);
title("Red channel \nwith rectangle");

subplot(2,4,7);
imshow(green_img_with_rectangle);
title("Green channel\nwith rectangle");

subplot(2,4,8);
imshow(blue_img_with_rectangle);
title("Blue channel\nwith rectangle");

% Save plot
print('A3_image_bit_planes.png')



