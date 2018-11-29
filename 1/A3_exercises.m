% load original image:
img = imread('A3_image.png');

# draw rectangle into original img
img_rect=img;
img_rect([1:100],[1:100],:) = 0;

img_r_rect=img(:,:,1);
img_r_rect(1:100,1:100) = 0;

img_g_rect= img(:,:,2);
img_g_rect(1:100,1:100) = 0;

img_b_rect=img(:,:,3);
img_b_rect(1:100,1:100) = 0;

%plot:
subplot(2,4,1);
imshow(img);
title("original");

subplot(2,4,2);
imshow(img(:,:,1));
title("Red channel");

subplot(2,4,3);
imshow(img(:,:,2));
title("Green channel");

subplot(2,4,4);
imshow(img(:,:,3));
title("Blue channel");

subplot(2,4,5);
imshow(img_rect);
title("Image with rectangle");

subplot(2,4,6);
imshow(img_r_rect);
title("Red channel with rectangle");

subplot(2,4,7);
imshow(img_g_rect);
title("Green channel with rectangle");

subplot(2,4,8);
imshow(img_b_rect);
title("Blue channel with rectangle");

% Save
print('A3_image_bit_planes.png')



