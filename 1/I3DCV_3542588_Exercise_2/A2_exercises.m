function A2_exercises
  
  % Exercise (i) Function Adding salt and pepper
  % Parameters are the image and the probability of a pixel to be salt or pepper
  % rel_amount_salt + rel_amount_pepper should be lower than 1
  function new_image = salt_and_pepper( img, rel_amount_salt, rel_amount_pepper)
    
    new_image = img;
    random_values = rand(size(img)(1),size(img)(2));
    
    % Adding salt
    new_image(random_values < rel_amount_salt) = 255;
    % Adding pepper
    new_image(random_values > (1-rel_amount_pepper)) = 0;

  endfunction

  % Exercise (ii) Own median filter without built-in median filter
  % Note the radius DOES not include the own value
  function new_image = convolve_with_median(img, neighbourhood_radius)
    
    new_image = zeros(size(img));
    % Note: We are still supposed to use zero-padding, so
    extended_img = zeros(size(img)+2*neighbourhood_radius);
    % Not important code, but it makes things clearer
    img_rows = size(img)(1);
    img_cols = size(img)(2);
    start_index = neighbourhood_radius+1; 
    end_index_rows = (neighbourhood_radius+img_rows);
    end_index_cols = (neighbourhood_radius+img_cols);
    
    % Add the zeros
    extended_img(start_index:end_index_rows,start_index:end_index_cols) = img;
    
    % Search for the median value within the neighbourhood of each pixel
    % This is a simple, non-optimized solution with loops
    for i = start_index:end_index_rows % for each row...
      for j = start_index:end_index_cols % ...and each col
        
        % Lets reset the neighbourhood to an empty vector
        neighbouring_values = [];
        
        % Get each value within the neighbourhood into a vector
        for x = -neighbourhood_radius:neighbourhood_radius
        
             % Add this values to the neighbourhood (Directly take the part of the row we need)
             neighbouring_values = [neighbouring_values, extended_img(i+x,(j-neighbourhood_radius):(j+neighbourhood_radius)) ];
            
        endfor

        % Now save the median from this neighbourhood into the image
        new_image(i-neighbourhood_radius,j-neighbourhood_radius) = median(neighbouring_values);
           
      endfor
    endfor
    
  endfunction

  % "1. Load your image of choise and convert it into greyscale."
  colored_img = imread('image.png');
  grey_img = rgb2gray(colored_img);

  % "2. Introduce salt and pepper noise."
  salty_peppered_img = salt_and_pepper(grey_img,0.05,0.05);
  
  % "3. Convolve the image with your median filter."
  neighbourhood_radius_without_self = 1;
  result_1 = uint8(convolve_with_median(salty_peppered_img,neighbourhood_radius_without_self));
  
  % "4. Convolve the image with the built-in Octave median filter."
  % We are using a rectangular filter-kernel again:
  result_2 = medfilt2(salty_peppered_img,ones(2*neighbourhood_radius_without_self+1));
  
  % "5. Assert that these two are equal."
  if result_1 == result_2 
    disp("The results are the same")
  else
    disp("The results are not the same!")
  endif

  % "6. Plot the original image, the image with salt and pepper noise, [etc.]"
  figure(1)
  subplot(2,2,1);
  imshow(grey_img);
  
  subplot(2,2,2);
  imshow(salty_peppered_img);
  
  subplot(2,2,3);
  imshow(result_1);

  subplot(2,2,4);
  imshow(result_2);
  
  print('A2_results.png');
  
endfunction
