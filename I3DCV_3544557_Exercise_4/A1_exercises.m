function A1_exercises
  
  clear all; 
  clf;
  
  # load the original image:
  img = imread('A1_image.png');
  grey_img = rgb2gray(img);
 
  %transformed_img=kirsch_filter(grey_img);
  %transformed_img=Sobel(grey_img);
  %transformed_img = edge(grey_img,"Sobel");
  %transformed_img = edge(grey_img,"LoG"); %Laplace of Gaussion
  transformed_img = edge(grey_img,"Kirsch",0.04);
  
  ## median filtering, its not neccesary as long as i use the build in edge function
  %transformed_img=medfilt2 (transformed_img);         # default is [3 3]
  %transformed_img=medfilt2 (transformed_img, [5 5]);  # 5 element wide square
   
  r = [ 54,61,69, 78];
  accum = hough_circle(transformed_img, r);
  
  figure(1);
  imshow(transformed_img);
  print("A1_transformed.png");
  
  %figure(2);
  %for i=1:size(r)(2)
  %  subplot(2,2,i);
   % imshow(accum(:,:,i),[0 max(max(accum(:,:,i)))]);
   % title(r(i));
  %endfor
 

  
  figure(3)
  imshow(accum(:,:,3),[0 max(max(accum(:,:,i)))]);
  print("A1_accumulated.png");
  
  figure(4)
  
  imshow(transformed_img.*100 + img./2 + accum(:,:,3),[0 max(max(accum(:,:,i)))]);
  title("detect 5 cent with r = 69")
  print("A1_detected.png");
  
  
endfunction
