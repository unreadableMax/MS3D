% load image:
original_img = imread('RandomImage.png');

img_with_rectangle=original_img;
img_with_rectangle([1:100],[1:100],:) = 0;

img_red_with_rectangle=original_img(:,:,1);
img_red_with_rectangle(1:100,1:100) = 0;

img_green_with_rectangle= original_img(:,:,2);
img_green_with_rectangle(1:100,1:100) = 0;

img_blue_with_rectangle=original_img(:,:,3);
img_blue_with_rectangle(1:100,1:100) = 0;

%plot:
subplot(2,4,1);
imshow(original_img);
title("original");

subplot(2,4,2);
imshow(original_img(:,:,1));
title("Red channel");

subplot(2,4,3);
imshow(original_img(:,:,2));
title("Green channel");

subplot(2,4,4);
imshow(original_img(:,:,3));
title("Blue channel");

subplot(2,4,5);
imshow(img_with_rectangle);
title("Image with rectangle");

subplot(2,4,6);
imshow(img_red_with_rectangle);
title("Red channel with rectangle");

subplot(2,4,7);
imshow(img_green_with_rectangle);
title("Green channel with rectangle");

subplot(2,4,8);
imshow(img_blue_with_rectangle);
title("Blue channel with rectangle");

% Save
print('A3_image_bit_planes.png')



