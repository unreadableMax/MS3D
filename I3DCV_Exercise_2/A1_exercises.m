 function A1_exercises
   
  function res_img = convolve_with_matrix33_nested_loops(img, kernel)
     
    % right kernel size?
    if (size(kernel)(1) != 3) or (size(kernel)(2) != 3)
      disp("convolve_with_matrix33_nested_loops: Wrong Kernel!")
      return
    endif          
    
    % get the size of the original image:
    img_y_size = size(img)(1);
    img_x_size = size(img)(2);
    
    img_with_frame = zeros(size(img)+2);
    
    % generate new image with frame, filed with zeros=black pixels:
    x_index = 2:(1+img_x_size);
    y_index = 2:(1+img_y_size);
    img_with_frame(y_index,x_index) = img;
    
    res_img = zeros(size(img));
    
    %finaly, do the convolution: 
    for y = 2:(1+img_y_size) 
      for x = 2:(1+img_x_size)
        % simply hard-coded:
        res_img(y-1,x-1) += img_with_frame(y-1,x-1) * kernel(1,1);
        res_img(y-1,x-1) += img_with_frame(y-1,x)   * kernel(1,2);
        res_img(y-1,x-1) += img_with_frame(y-1,x+1) * kernel(1,3);
        res_img(y-1,x-1) += img_with_frame(y,x-1)   * kernel(2,1);
        res_img(y-1,x-1) += img_with_frame(y,x)     * kernel(2,2);
        res_img(y-1,x-1) += img_with_frame(y,x+1)   * kernel(2,3);
        res_img(y-1,x-1) += img_with_frame(y+1,x-1) * kernel(3,1);
        res_img(y-1,x-1) += img_with_frame(y+1,x)   * kernel(3,2);
        res_img(y-1,x-1) += img_with_frame(y+1,x+1) * kernel(3,3);
      endfor
    endfor
  endfunction

  
  function res_img = convolve_with_matrix33_flat_loops( img, kernel_x, kernel_y)
     
    if (size(kernel_x)(1) != 1) or (size(kernel_x)(2) != 3)
      disp("convolve_with_matrix33_flat_loops: Wrong kernel!")
      return
    endif
    
    if (size(kernel_y)(1) != 3) or (size(kernel_y)(2) != 1)
      disp("convolve_with_matrix33_flat_loops: Wrong kernel!")
      return
    endif
    
    res_img = zeros(size(img));
    
    img_y_size = size(img)(1);
    img_x_size = size(img)(2);
     
    %Convolution with two loops:
    for y = 1:img_y_size 
      res_img(y,:) = conv(img(y,:),kernel_x,"same");
    endfor
    
    for x = 1:img_x_size 
      res_img(:,x) = conv(res_img(:,x),kernel_y,"same");
    endfor
    
  endfunction
  
  % load img:
  img = imread('image.png');
  img = rgb2gray (img);
  
  % lets use the mean-kernel:
  kernel_x = [1, 1, 1]/3;
  kernel_y = [1; 1; 1]/3;
  
  % generate 3x3 kernel, based on kernel_x and kernel_y:
  kernel = conv2(kernel_x,kernel_y,"full")
  
  % use 3 methods for convolution:
  nested_loop_res = uint8(convolve_with_matrix33_nested_loops(img, kernel));
  flat_loops_res = uint8(convolve_with_matrix33_flat_loops(img, kernel_x, kernel_y));
  conv2_res = uint8(conv2(img,kernel, "same"));

  if(nested_loop_res == conv2_res && nested_loop_res == flat_loops_res)
    disp("All results are equal")
  else
    disp("got different results!")
  endif
  
  %plot results:
  figure(1)
  subplot(2,2,1)
  imshow(img);
  
  subplot(2,2,2)
  imshow(nested_loop_res);
  
  subplot(2,2,3)
  imshow(flat_loops_res);
  
  subplot(2,2,4)
  imshow(conv2_res);
  
endfunction
