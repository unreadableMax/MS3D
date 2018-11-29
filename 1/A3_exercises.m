% load image:
original_img = imread('RandomImage.png');

% get red, green and blue channels:
img_red = original_img(:,:,1);
img_green = original_img(:,:,2);
img_blue = original_img(:,:,3);

%...LESEZEICHEN!!!
original_img_with_rectangle=original_img;
original_img_with_rectangle([1:100],[1:100],:) = 0;

img_red_with_rectangle=img_red;
img_red_with_rectangle(1:100,1:100) = 0;

img_green_with_rectangle= img_green;
img_green_with_rectangle(1:100,1:100) = 0;

img_blue_with_rectangle=img_blue;
img_blue_with_rectangle(1:100,1:100) = 0;

%Plot stuff:

subplot(2,4,1);
imshow(original_img);
title("original Image");

subplot(2,4,2);
imshow(img_red);
title("Red channel");

subplot(2,4,3);
imshow(img_green);
title("Green channel");

subplot(2,4,4);
imshow(img_blue);
title("Blue channel");

subplot(2,4,5);
imshow(original_img_with_rectangle);
title("Image with rectangle");

subplot(2,4,6);
imshow(img_red_with_rectangle);
title("Red channel \nwith rectangle");

subplot(2,4,7);
imshow(img_green_with_rectangle);
title("Green channel\nwith rectangle");

subplot(2,4,8);
imshow(img_blue_with_rectangle);
title("Blue channel\nwith rectangle");

% Save plot
print('A3_image_bit_planes.png')



