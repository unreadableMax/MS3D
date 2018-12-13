function A2_exercises
 
  function salted_peppered_img = salt_and_pepper( img, salt_chance, pepper_chance)
    
    salted_peppered_img = img;
    
    random_salt = rand(size(img)(1),size(img)(2));
    random_pepper = rand(size(img)(1),size(img)(2));
    
    %generate salt and pepper masks:
    salt_mask = (random_salt < salt_chance);
    pepper_mask = (random_pepper < salt_chance);
    
    %us masks to salt and pepper the img:
    salted_peppered_img(salt_mask) = 255;
    salted_peppered_img(pepper_mask) = 0;

  endfunction

  function res_img = convolve_with_median(img, r)
    
    res_img = zeros(size(img));
    img_with_frame = zeros(size(img)+2*r);
    
    start_index = r+1; 
    end_index_y = (r+size(img)(1));
    end_index_x = (r+size(img)(2));
    
    img_with_frame(start_index:end_index_y,start_index:end_index_x) = img;
    
    for y = start_index:end_index_y 
      for x = start_index:end_index_x
        
        % searching neighbors and store them indo a vector:
        neighbours = [];
        for i = -r:r 
             neighbours = [neighbours, img_with_frame(y+i,(x-r):(x+r)) ];
        endfor

        % Now apply octaves median-function on our neighbours:
        res_img(y-r,x-r) = median(neighbours);
           
      endfor
    endfor
    
  endfunction
  
  pkg load image

  % load original image:
  img = imread('image.png');
  img = rgb2gray(img);

  noisy_image = salt_and_pepper(img,0.1,0.06);
  
  r = 1;
  own_median_filter_res = uint8(convolve_with_median(noisy_image,r));
  
  mask = ones(2*r+1);
  medfilt2_res = medfilt2(noisy_image,mask);
  
  if own_median_filter_res == medfilt2_res 
    disp("both results are equal")
  else
    disp("res1 != res2")
    return
  endif

  % plot all the stuff:
  figure(1)
  subplot(2,2,1);
  imshow(img);
  
  subplot(2,2,2);
  imshow(noisy_image);
  
  subplot(2,2,3);
  imshow(own_median_filter_res);

  subplot(2,2,4);
  imshow(medfilt2_res);
  
  print('A2_results.png');
  
endfunction
