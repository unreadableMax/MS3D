function A2_exercises
  % based on the code, prvided by slides. 
  % But i fixed some lines - so i didn't just copy pased the code
  function [im_ii_vol] = iivolume_filter(im,radius)
    
    fw=2*radius+1;
    
    [xx,yy]=meshgrid(-radius:+radius);
    % normalize the mask
    radiiBase = sqrt(xx.^2 + yy.^2)./radius;

    % values higher than 1 ar not a number
    radiiBase(find(radiiBase>1.0))=nan;
    s_melt = sqrt(1.0 - radiiBase.^2); %(radius/radius)^2=1
    s_plus = 2.0*s_melt;
    
    % plot the meltet sphere:
    figure(1);
    mesh (xx, yy, s_plus);
    title("melted sphere+");
    
    for ix=1:size(im,1)-fw
      for iy=1:size(im,2)-fw
        subimage = im(ix:ix+fw-1,iy:iy+fw-1);
        centralpix = subimage(radius,radius);
        h = subimage - centralpix - s_melt;
        subimage_min = min(h,s_plus);
        
        %don't apply negative values:
        subimage_min(find(h<0.0))=0.0;
        subimage_min(find(isnan(radiiBase)))=0.0;
        
        im_ii_vol(ix,iy)=sum(subimage_min(:));
      endfor
    endfor
    im_ii_vol/=sum(s_plus(find(isfinite(s_plus))));

  endfunction
  
  clear all; 
  clf;
  
  img1 = imread('A2_image_1.png');
  grey_img = rgb2gray(img1);
  img_size1=size(grey_img)
  res1 = iivolume_filter(grey_img,10);
  
  img2 = imread('A2_image_2.png');
  grey_img2 = rgb2gray(img2);
  img_size2=size(grey_img2)
  res2 = iivolume_filter(grey_img2,10);
  
  figure(2);
  subplot(1,2,1);
  imshow(img1);
  subplot(1,2,2);
  imshow(res1);
  
  figure(3);
  subplot(1,2,1);
  imshow(img2);
  subplot(1,2,2);
  imshow(res2);
  
endfunction
