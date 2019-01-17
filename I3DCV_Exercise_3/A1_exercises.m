function A1_exercises
  
  clear variables;
  clear all;
  
  % Exercise 1 (i)
  data_sandhausen = load("sandhausen_sample.xyz","ascii");
  
  % If the size is too big, the performance of the script drops into oblivion  
  % (buffer overflow propably, but googling didn't help), also setting the color 
  % within scatter3 destroys a quick run through. Also having scatter draw too 
  % many points may cause Octave too crash consistently
  data_sandhausen = data_sandhausen(1:10:length(data_sandhausen),:);
  
  data_x = data_sandhausen(:,1);
  data_y = data_sandhausen(:,2);
  data_z = data_sandhausen(:,3);
  
  %from a quick peak into the data set:
  resolution = 30; 

  % Keep the color range between 0 and 1
  highest_z = max(data_z);
  lowest_z = min(data_z);
  color_range = (data_z - lowest_z)/(highest_z - lowest_z);

  figure(1);
  scatter3(data_x, data_y, data_z, resolution, color_range);
  %scatter3(data_x, data_y, data_z);
 
endfunction
