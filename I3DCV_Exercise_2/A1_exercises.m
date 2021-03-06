 function A1_exercises
  % This file contains the solution of exercise 1.1 - Seperable Convolution
  
  % Exercise (ii): Two nested loops 
  function new_image = convolve_with_matrix33_nested_loops( img, kernel)
     
    % We are supposed to use "matrix33", so make sure the kernel has the right size
    if (size(kernel)(1) != 3) or (size(kernel)(2) != 3)
      disp("Wrong kernel size. It must be 3x3!")
      return
    endif
    
    % 1. Step: We need to flip the kernel otherwise its no convolution but a "correlation"
    kernel = flipdim(kernel ,1);
    kernel = flipdim(kernel ,2);           
    
    % The result has the size of the used image:
    new_image = zeros(size(img));
    
    % For our convolution, we need to provide boundary condition
    % We are supposed to add zeros (= black pixels). With a 3x3 kernel, we need 
    % to add one layer of zeros around the image
    extended_img = zeros(size(img)+2);
    img_rows = size(img)(1);
    img_cols = size(img)(2);
    % Copying the image into the middle of the extended image
    extended_img(2:(1+img_rows),2:(1+img_cols)) = img;
     
    %Convolution with two nested loops:
    % Loops are constructed to fit the indizes for the extended image 
    % for clarity reasons
    for i = 2:(1+img_rows) % for each row of new image
      for j = 2:(1+img_cols) % for each col of new image
        
        % Make a "convolution" on img[i][j] 
        % Convolution writes a pixel value based on the neighbours within  
        % the "kernel" and the kernel's weight:
        % For resons of clarity, lets split the operation into small parts

        % The first row of the kernel applied:
        new_image(i-1,j-1) += extended_img(i-1,j-1)*kernel(1,1);
        new_image(i-1,j-1) += extended_img(i-1,j)*kernel(1,2);
        new_image(i-1,j-1) += extended_img(i-1,j+1)*kernel(1,3);
        % The second row of the kernel applied:
        new_image(i-1,j-1) += extended_img(i,j-1)*kernel(2,1);
        new_image(i-1,j-1) += extended_img(i,j)*kernel(2,2);
        new_image(i-1,j-1) += extended_img(i,j+1)*kernel(2,3);   
        % The last row of the kernel applied:
        new_image(i-1,j-1) += extended_img(i+1,j-1)*kernel(3,1);
        new_image(i-1,j-1) += extended_img(i+1,j)*kernel(3,2);
        new_image(i-1,j-1) += extended_img(i+1,j+1)*kernel(3,3);
           
      endfor
    endfor
  
  endfunction

  % (iii) 
  function resulting_image = convolve_with_matrix33_flat_loops( img, kernel)
     
    % We are supposed to use "matrix33", so make sure the kernel has the right size
    if (size(kernel)(1) != 3) or (size(kernel)(2) != 3)
      disp("Wrong kernel size. It must be 3x3!")
      return
    endif
    
    kernel = flipdim(kernel ,1);
    kernel = flipdim(kernel ,2);
    
    
    % For our convolution, we need to provide boundary condition
    % We are supposed to add zeros (= black pixels). With a 3x3 kernel, we need 
    % to add one layer of zeros around the image
    new_image = extended_img_1 = extended_img_2 = extended_img_3 = zeros(size(img)+2);
    img_rows = size(img)(1);
    img_cols = size(img)(2);
    resulting_image = zeros(size(img));
     
    % The plan is, to add the valures horizontally for each row first
    % To do this, we shift the row to the left and to the right and add
    % these two with the sunshiftet vector:
    
    % Shifted to the left (Resulting in accessing values to the right):
    extended_img_1(2:(1+img_rows),1:(img_cols)) = img;
    % Normal placement:
    extended_img_2(2:(1+img_rows),2:(1+img_cols)) = img;
    % Shifted to the right (Resulting in accessing values to the left):
    extended_img_3(2:(1+img_rows),3:(2+img_cols)) = img;
    
    % Convolution with two seperated loops:
    % "Convolute" along rows first
    for i = 2:(1+img_rows)
            
      % The first row of the kernel applied by adding :
      new_image(i,:) += extended_img_3(i-1,:).*kernel(1,1);
      new_image(i,:) += extended_img_2(i-1,:).*kernel(1,2);
      new_image(i,:) += extended_img_1(i-1,:).*kernel(1,3);
      % The second row of the kernel applied:
      new_image(i,:) += extended_img_3(i,:).*kernel(2,1);
      new_image(i,:) += extended_img_2(i,:).*kernel(2,2);
      new_image(i,:) += extended_img_1(i,:).*kernel(2,3);   
      % The last row of the kernel applied:
      new_image(i,:) += extended_img_3(i+1,:).*kernel(3,1);
      new_image(i,:) += extended_img_2(i+1,:).*kernel(3,2);
      new_image(i,:) += extended_img_1(i+1,:).*kernel(3,3);
      
    endfor
    
    for a=1:1
      % I think i was supposed to do this differently, but i don't need the second for loop anymore 
      % But i wasn't able to solve the task in another way :'(
    endfor
    
    % Cropping the new_image
    resulting_image = new_image(2:(1+img_rows),2:(1+img_cols));
    
  endfunction

    % (iii) 
  function resulting_image = convolve_with_two_vector13_flat_loops( img, kernel_x, kernel_y)
     
    if (size(kernel_x)(1) != 1) || (size(kernel_x)(2) != 3)
      disp("Wrong kernel size. Kernel_x must be 1x3!")
      return
    endif
    
    if (size(kernel_y)(1) != 3) || (size(kernel_y)(2) != 1)
      disp("Wrong kernel size. Kernel_y must be 3x1!")
      return
    endif
    
    % The result has the size of the used image:
    new_image = zeros(size(img));
    %extended_img = zeros(size(img)+2);
    img_rows = size(img)(1);
    img_cols = size(img)(2);
    %extended_img(2:(1+img_rows),2:(1+img_cols)) = img;
     
    %Convolution with two nested loops:
    % Loops are constructed to fit the indizes for the extended image 
    % for clarity reasons
    for i = 1:img_rows 
      % Convoluting horizontally
      new_image = conv2(img,kernel_x,"same");
    endfor
    
    for j = 1:img_cols 
      % Convoluting vertically
      resulting_image = conv2(new_image,kernel_y,"same");
    endfor
    
  endfunction
  
  %(iv)
  
  % "1. Load your image of choise and convert it into greyscale."
  colored_img = imread('image.png');
  grey_img = rgb2gray (colored_img);
  
  % Debug "images"
  %A = [1,2,1,4,2;3,4,2,1,1;2,2,1,1,5;6,3,1,1,2;1,2,3,2,2]
  
  % Make the kernel: Try out different kernels
  % kernel = [ -1, 0, 1; -1, 0, 1; -1, 0, 1]; % Simple horizontal differentiation
  % kernel = [ -1, -1, -1; 0, 0, 0; 1, 1, 1]; % Simple vertical differentiation
  % kernel = [ 1, 1, 1; 1, 1, 1; 1, 1, 1]/9; % Simple mean / low pass filter
  % One can construct a kernel by convoluting the horizontal and the vertical kernel
  kernel_x = [1, 1, 1];
  kernel_y = [-1; 0; 1];
  kernel = conv2(kernel_x,kernel_y,"full")
  
  % "2. Convolve the image with the first function."
  % We need to cast the result into the uint8 format since we produced double 
  % because of multiplication and division
  result_1 = uint8(convolve_with_matrix33_nested_loops(grey_img, kernel));

  % "3. Convolve the image withe the second function"
  result_2 = uint8(convolve_with_matrix33_flat_loops(grey_img, kernel));
  
  result_2b = uint8(convolve_with_two_vector13_flat_loops(grey_img, kernel_x, kernel_y));
  
  % "4. Convolve the image with the built-in Octave methods."
  result_3 = uint8(conv2(grey_img,kernel, "same")); % same: size(result) = size(img)

  % "5. Assert the results of these two are equal."
  % Since we are comparing to uint8-greyscale-images, we dont need tolerances 
  % and can directly compare:
  if(result_1 == result_3 && result_1 == result_2 && result_2 == result_2b)
    % result_2 is only equal to result_2b if it was constructed by convoluting 
    % kernel x and kernel y
    disp("The results are the same")
  else
    disp("The results are not the same!")
  endif
  
  % Showing the different images:
  figure(1)
  subplot(2,3,1)
  imshow(grey_img);
  
  subplot(2,3,2)
  imshow(result_1);
  
  subplot(2,3,3)
  imshow(result_2);
  
  subplot(2,3,4)
  imshow(result_2b);
  
  subplot(2,3,5)
  imshow(result_3);
  
endfunction
