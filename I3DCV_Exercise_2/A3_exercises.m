function A3_exercises
  
  function res_img = supress_non_maxima( img, radius_vector )
    
    res_img = zeros(size(img));
    img_y_size = size(img)(1);
    img_x_size = size(img)(2);
    
    radius_y = radius_vector(1); 
    radius_x = radius_vector(2);
    
    img_with_0frame = zeros(img_y_size+2*radius_y,img_x_size+2*radius_x);
    
    % using indexes to navigate inside img_with_0frame, 
    % without touching thezero frame:
    start_index_y = radius_y+1; 
    start_index_x = radius_x+1; 
    end_index_y = (radius_y+img_y_size);
    end_index_x = (radius_x+img_x_size);
    
    % filling the inner part of img_with_0frame with the original img:
    img_with_0frame(start_index_y:end_index_y,start_index_x:end_index_x) = img;
   
   % go through the inner part of img_with_0frame:
    for y = start_index_y:end_index_y
      for x = start_index_x:end_index_x

        % get neighbours (including "myself")
        neighbours = img_with_0frame((y-radius_y):(y+radius_y),(x-radius_x):(x+radius_x));
        
        %don't want to count myself to the neighbours, so lets delete myself:
        neighbours(radius_y+1,radius_x+1)=0;
        
        %find the highest value in the neighbourhood:
        greatest_neighbour = max(max(neighbours));
        
        % if we can beat the greatest neighbour, we finaly won, and get not deleted!
        if(img_with_0frame(y,x) > greatest_neighbour)
            res_img(y-radius_y,x-radius_x)=img_with_0frame(y,x);
        endif
        
      endfor
    endfor
    
  endfunction
  
  img = imread('image.png');
  img = rgb2gray(img);
  
  G_x = conv2(img,[ 3,0,-3; 10,0,-10; 3,0,-3]/16,"same");
  G_y = conv2(img,[ 3,10,3; 0,0,0; -3,-10,-3]/16,"same");
  
  result_1 = uint8(sqrt( G_x.*G_x + G_y.*G_y ));

  result_2 = uint8(supress_non_maxima(result_1,[1 1]));
  
  % ----PLot----
  figure(1)
  subplot(2,2,1);
  imshow(img);
  
  subplot(2,2,2);
  imshow(result_1);
  
  subplot(2,2,3);
  imshow(result_2);
  
  subplot(2,2,4);
  imshow(result_2+result_1);
  
  print('A3_results.png');
  
endfunction
