function A2_exercises
  
  # add salt and pepper to an imput img
  function res = salt_and_pepper( img, pepp_factor,salt_factor)
    res = img;
    random_values = rand(size(img)(1),size(img)(2));
    res(random_values < salt_factor) = 255;
    res(random_values > (1-pepp_factor)) = 0;
  endfunction

  # nice to clean up a noisy picture 
  function res = convolve_with_median(img, conv_rad)
    
    # allocate result image:
    res = zeros(size(img));
    
    # alloc greater img with black border:
    img_border = zeros(size(img)+2*conv_rad);
    
    rows = size(img)(1);
    collums = size(img)(2);
    start_index = conv_rad+1; 
    end_index_rows = (conv_rad+rows);
    end_index_cols = (conv_rad+collums);
    
    img_border(start_index:end_index_rows,start_index:end_index_cols) = img;
    
    % Search for the median value within the neighbourhood of each pixel
    for i = start_index:end_index_rows 
      for j = start_index:end_index_cols
        
        % reset neighbourhood to an empty vector
        neighborhood = [];
        
        for x = -conv_rad:conv_rad 
             % Add to the neighbourhood (Directly take the part of the row we need)
             neighborhood = [neighborhood, img_border(i+x,(j-conv_rad):(j+conv_rad)) ];
            
        endfor

        % save median from neighbourhood 
        res(i-conv_rad,j-conv_rad) = median(neighborhood);
           
      endfor
    endfor
    
  endfunction
  
  # load image pkg 
  pkg load image

  # load image:
  img = imread('image.png');
  grey_img = rgb2gray(img);
  
  # add some salt and pepper:
  salty_img = salt_and_pepper(grey_img,0.1,0.1);
  
  # set convolution radius here:
  conv_rad = 2;
  
  # use our own median function:
  res_a = uint8(convolve_with_median(salty_img,conv_rad));
  
  # use the oracle-function:
  res_b = medfilt2(salty_img,ones(2*conv_rad+1));
  
  #compare results:
  if res_a == res_b 
    disp("ok, same results")
  else
    disp("ERROR: different results!")
  endif

   #plot the hole think:
  subplot(2,2,1);
  imshow(grey_img);
  
  subplot(2,2,2);
  imshow(salty_img);
  
  subplot(2,2,3);
  imshow(res_a);

  subplot(2,2,4);
  imshow(res_b);
  
  print('A2_results.png');
  
endfunction
