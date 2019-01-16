function A1_exercises
  
  % Exercise 1 (i)
  data_sandhausen = load("sandhausen_sample.xyz","ascii");
  data_x = data_sandhausen(:,1);
  data_y = data_sandhausen(:,2);
  data_z = data_sandhausen(:,3);

  %from a quick peak into the data set:
  resolution_xy = 0.1; 

  % Keep the color range between 0 and 1
  highest_z = max(data_z);
  lowest_z = min(data_z);
  color_range = (data_z - lowest_z)/(highest_z - lowest_z);

  figure(1);
  scatter3(data_x, data_y, data_z, resolution_xy, color_range);

  % Exercise 1 (ii)
  print("A1_result.png");
 
endfunction
