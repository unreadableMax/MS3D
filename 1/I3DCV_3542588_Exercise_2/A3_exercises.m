function A3_exercises
  
  % Exercise (i): Function supressing non-maximas
  function new_image = supress_non_maxima( img, size_neighbourhood )
    
    new_image = zeros(size(img));
    img_rows = size(img)(1);
    img_cols = size(img)(2);
    
    %Assuming an odd neighbourhood
    neighbourhood_radius_rows = (size_neighbourhood(1) - 1)/2; 
    neighbourhood_radius_cols = (size_neighbourhood(2) - 1)/2;
    
    extended_img = zeros(img_rows+2*neighbourhood_radius_rows,img_cols+2*neighbourhood_radius_cols);
    start_index_rows = neighbourhood_radius_rows+1; 
    start_index_cols = neighbourhood_radius_cols+1; 
    end_index_rows = (neighbourhood_radius_rows+img_rows);
    end_index_cols = (neighbourhood_radius_cols+img_cols);
    extended_img(start_index_rows:end_index_rows,start_index_cols:end_index_cols) = img;
   
    % Based on the definition of the exercise sheet
    for i = start_index_rows:end_index_rows
      for j = start_index_cols:end_index_cols
        
        % Lets reset the neighbourhood to an empty vector
        neighbouring_values = [];
        % Get each value within the neighbourhood into a vector
        for x = -neighbourhood_radius_rows:neighbourhood_radius_rows
          % Add this values to the neighbourhood (Directly take the part of the row we need)
          neighbouring_values = [neighbouring_values, extended_img(i+x,(j-neighbourhood_radius_cols):(j+neighbourhood_radius_cols)) ];
        endfor

        % Set value to zero if its not the highest 
        % According to the formular in the exercise sheet, 
        sorted_neighbourhood = sort(neighbouring_values, "descend");
        %Now if the own value is higher than all others, let it pass
        if ((extended_img(i,j) == sorted_neighbourhood(1)) && (sorted_neighbourhood(1) > sorted_neighbourhood(2)))
            new_image(i,j) = extended_img(i,j);
        endif %else keep it 0
        
      endfor
    endfor
    
  endfunction
  
  % Exercise (ii)
  
  % "1. Load your image of choise and convert it into greyscale."
  colored_img = imread('image.png');
  grey_img = rgb2gray(colored_img);
  
  % "2. Convolve the image with a kernel of your choise to extract edges
  % Choice: Scharr Operator (slides Lecture 3), because it's simple but
  % good enough for our task
  G_x = conv2(grey_img,[ 3,0,-3; 10,0,-10; 3,0,-3]/16,"same");
  G_y = conv2(grey_img,[ 3,10,3; 0,0,0; -3,-10,-3]/16,"same");
  %G_x = conv2(grey_img,[ 1,0,-1; 1,0,-1; 1,0,-1]/6,"same");
  %G_y = conv2(grey_img,[ 1,1,1; 0,0,0; -1,-1,-1]/6,"same");
  result_1 = uint8(sqrt( G_x.*G_x + G_y.*G_y ));

  % "3. Perform non-maximum suppression of the results
  result_2 = uint8(supress_non_maxima(result_1,[3 3]));
  
  % "4. Plot [everything]
  figure(1)
  subplot(2,2,1);
  imshow(grey_img);
  
  subplot(2,2,2);
  imshow(result_1);
  
  subplot(2,2,3);
  imshow(result_2);
  % The non-maxima suppression is intended to reduce edges to a single line, but 
  % the edge detection produces no big lines, so the the suppression "fails"
  % This is independend from the images. Are we supposed to produce thick lines 
  % with our edge detection?
  
  print('A3_results.png');
  
endfunction
