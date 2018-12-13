 function A1_exercises
   
  function convolved_img = convolve_with_matrix33_nested_loops( img, kernel)         
    
    # allocate zero-matrix for the result:
    convolved_img = zeros(size(img));
    
    # Copying the image into the middle of the extended image:
    img_with_border = zeros(size(img)+2);
    original_rows = size(img)(1);
    original_colums = size(img)(2);
    img_with_border(2:(1+original_rows),2:(1+original_colums)) = img;
     
    for i = 2:(1+original_rows) 
      for j = 2:(1+original_colums)
        # do the hole convoluten by hand:
        convolved_img(i-1,j-1) += img_with_border(i-1,j-1)*kernel(1,1);
        convolved_img(i-1,j-1) += img_with_border(i-1,j)*kernel(1,2);
        convolved_img(i-1,j-1) += img_with_border(i-1,j+1)*kernel(1,3);
        convolved_img(i-1,j-1) += img_with_border(i,j-1)*kernel(2,1);
        convolved_img(i-1,j-1) += img_with_border(i,j)*kernel(2,2);
        convolved_img(i-1,j-1) += img_with_border(i,j+1)*kernel(2,3); 
        convolved_img(i-1,j-1) += img_with_border(i+1,j-1)*kernel(3,1);
        convolved_img(i-1,j-1) += img_with_border(i+1,j)*kernel(3,2);
        convolved_img(i-1,j-1) += img_with_border(i+1,j+1)*kernel(3,3);
      endfor
    endfor
  
  endfunction

  
  function convolved_img = convolve_with_matrix33_flat_loops( img, kernel_x, kernel_y)

    # The result has the size of the used image:
    convolved_img = zeros(size(img));
    
    original_rows = size(img)(1);
    original_colums = size(img)(2);
    
    # horizontally:
    for i = 1:original_rows 
      convolved_img(i,:) = conv(img(i,:),kernel_x,"same");
    endfor
    
    # vertically:
    for j = 1:original_colums 
      convolved_img(:,j) = conv(convolved_img(:,j),kernel_y,"same");
    endfor
    
  endfunction
  
  # load the original image:
  img = imread('image.png');
  grey_img = rgb2gray (img);
  
  # use a kernel to get an unfocused effect:
  kernel_x = [1,1,1]/3;
  kernel_y = [1;1;1]/3;
  kernel = conv2(kernel_x,kernel_y,"full")
  
  res_a = uint8(convolve_with_matrix33_nested_loops(grey_img, kernel));

  res_b = uint8(convolve_with_matrix33_flat_loops(grey_img, kernel_x, kernel_y));
  
  res_c = uint8(conv2(grey_img,kernel, "same")); 

  if(res_a == res_c && res_a == res_b)
    disp("ok, same results")
  else
    disp("ERROR: different results!")
  endif
  
  % Showing the different images:
  figure(1)
  subplot(2,2,1)
  imshow(grey_img);
  
  subplot(2,2,2)
  imshow(res_a);
  
  subplot(2,2,3)
  imshow(res_b);
  
  subplot(2,2,4)
  imshow(res_c);
  
endfunction
