function A3_exercises
  
  function res_img = supress_non_maxima( img, conv_size_2D )
    
    res_img = zeros(size(img));
    img_y_size = size(img)(1);
    img_x_size = size(img)(2);
    
    radius_y = (conv_size_2D(1) - 1)/2; 
    radius_x = (conv_size_2D(2) - 1)/2;
    
    img_with_0frame = zeros(img_y_size+2*radius_y,img_x_size+2*radius_x);
    
    start_index_y = radius_y+1; 
    start_index_x = radius_x+1; 
    end_index_y = (radius_y+img_y_size);
    end_index_x = (radius_x+img_x_size);
    
    img_with_0frame(start_index_y:end_index_y,start_index_x:end_index_x) = img;
   
    for y = start_index_y:end_index_y
      for x = start_index_x:end_index_x
        
        #neighbours = [];
        #for i = -radius_y:radius_y
       #   neighbours = [neighbours, img_with_0frame(y+i,(x-radius_x):(x+radius_x)) ];
       # endfor
        
        neighbours = img_with_0frame((y-radius_y):(y+radius_y),(x-radius_x):(x+radius_x));
        
        %don't want to count myself to the neighbours:
        neighbours(y,x)=0;
        greatest_neighbour = max(max(neighbours));
        
        if(img_with_0frame(y,x) > greatest_neighbour)
            res_img()
        endif

      #  sorted_neighbourhood = sort(neighbours, "descend");
        
       # if ((img_with_0frame(y,x) == sorted_neighbourhood(1)) && (sorted_neighbourhood(1) > sorted_neighbourhood(2)))
       #     res_img(y,x) = img_with_0frame(y,x);
       # endif 
        
      endfor
    endfor
    
  endfunction
  
  colored_img = imread('image.png');
  grey_img = rgb2gray(colored_img);
  
  G_x = conv2(grey_img,[ 3,0,-3; 10,0,-10; 3,0,-3]/16,"same");
  G_y = conv2(grey_img,[ 3,10,3; 0,0,0; -3,-10,-3]/16,"same");
  
  result_1 = uint8(sqrt( G_x.*G_x + G_y.*G_y ));

  result_2 = uint8(supress_non_maxima(result_1,[3 3]));
  
  % PLot
  figure(1)
  subplot(2,2,1);
  imshow(grey_img);
  
  subplot(2,2,2);
  imshow(result_1);
  
  subplot(2,2,3);
  imshow(result_2);
  
  print('A3_results.png');
  
endfunction
