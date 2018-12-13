function A3_exercises
  
  function res = supress_non_maxima( img, radius )
    
    #alloc res-matrix:
    res = zeros(size(img));
    
    #get matrix dimensions:
    rows = size(img)(1);
    colls = size(img)(2);
    
    #alloc img with border:
    img_border = zeros(rows+2*radius,colls+2*radius);
    
    #fill it with img:
    img_border((radius+1):(radius+rows),(radius+1):(radius+colls)) = img;
   
    # apply the given algorithm:
    for i = (radius+1):(radius+rows)
      for j = (radius+1):(radius+colls)
        
        # find neighbors:
        neighbouring_values = [];
        for x = -radius:radius
          neighbouring_values = [neighbouring_values, img_border(i+x,(j-radius):(j+radius)) ];
        endfor

        #sort the neighbors:
        sorted_neighbourhood = sort(neighbouring_values, "descend");
        
        if ((img_border(i,j) == sorted_neighbourhood(1)) && (sorted_neighbourhood(1) > sorted_neighbourhood(2)))
            res(i-radius,j-radius) = img_border(i,j);
        endif %else keep it 0
        
      endfor
    endfor
    
  endfunction
  
  #load the image:
  colored_img = imread('image.png');
  grey_img = rgb2gray(colored_img);
  
  # derivative the image:
  res_x = conv2(grey_img,[ 3,0,-3; 10,0,-10; 3,0,-3]/16,"same");
  res_y = conv2(grey_img,[ 3,10,3; 0,0,0; -3,-10,-3]/16,"same");
  res_a = uint8(sqrt( res_x.*res_x + res_y.*res_y ));
  
  #apply supress_non_maxima:
  r=1;
  res_b = uint8(supress_non_maxima(res_a,r));
  
  # plot results:
  figure(1)
  subplot(2,2,1);
  imshow(grey_img);
  
  subplot(2,2,2);
  imshow(res_a);
  
  subplot(2,2,3);
  imshow(res_b);
  
  print('A3_results.png');
  
endfunction
