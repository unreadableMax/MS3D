function A2_exercises
 
  clear all; 
  close all;
 
  % Exerise 2 (ii)
  % Let p,q ? P denote two points in a point-cloud P ?R3. 
  % Let ~z = [0,0,-1] be a vector pointing in the direction of the ground. 
  % Let ~g = [1,1,0] be a vector denoting the ground plane. 
  % Let <�,�> denote the the dot product, i.e. projection of a vector. 
  % Let ? be a threshold denoting the amount of detail you want to extract.
  % Then, a point p is in the DTM point-cloud � P only if the following holds.
  % �P = {p |?p,q ? P : ||<p,~g> - <q,~g>|| < ? and <p,~z> > <q,~z>}
  function DTM_points = getDTM(dataset_P, detail_threshold_lambda)
  
    % Attempt: We want to keep all points that fulfill 
    % the condition described by the description above:
    % ^P contains p for all pairs p,q , with p as well as q being from P,
    % if the following requierements are met:
    % 1. abs( dot(p,~g) - dot(q,~g) ) < lambda 
    % 2. dot(p,~z) > dot(q,~z)

    % Note: The length of a dot product represent |a|*|b|*cos(angle)
    % --> Both conditions compare p and q to each other based on either g or z, 
    % making |b| irrelevant for the comparison as it gets canceled out
    % --> The value is zero if the two vectors in a dot product
    % are perpendicular to each other. The value is the highest 
    % if they show in the same direction. Therefore, assuming the vectors p and q
    % have more or less the same length, a dot product is greater than 
    % the other if they are closer to the compared direction
  
    % Therefore,
    % The first condition demands that
    % |p|*cos(angle_to_ground) ~~ |q|*cos(angle_to_ground)
    % which is fulfilled if they are close to each other i guess?
    % the second condition demands that the vector p must have 
    % to a smaller z-value than q
  
    % Somehow i dont think that these algorithm works flawless since the condition
    % 1 can be true even if the angle is completely different since |a| matters,
    % but okay, lets just implement this
  
    % data set must have dim n x 3
    if( size(dataset_P,2) != 3)
      disp("Wrong dimensions. dataset_P must be n x 3");
      return
    endif
    
    % "initialization
    DTM_points = [];
  
    % g like described in the task
    % g gets allocated with the size of P because it gets compared with every 
    % point of P later
    g = zeros(size(dataset_P));
    g += [1,1,0];
  
    % We'll check each point p in dataset_P (optimizing later)
    for i=1:size(dataset_P,1)
    
      % p is the point we are currently checking 
      p = zeros(size(dataset_P));
      p += dataset_P(i,:);
    
      % First condition is true where difference between the dot product between 
      % p and g and the dot product between P and g is below lambda 
      % First condition is true where we can consider a point of P to be a 
      % "neighbour" of p 
      first_condition = abs( dot(p,g,2) - dot(dataset_P,g,2) ) <= detail_threshold_lambda;  
      
      % p is not a neighbour of p
      first_condition(i) = 0;
      
      % Collect every point for which this condition holds true in q
      % "q is where a point in P is considered a neighbour of P"
      q = dataset_P(first_condition,:);
     
      % z like described in the task
      % z gets allocated with the size of q because it gets compared with every 
      % point of q 
      z = zeros(size(q));
      z += [0,0,-1];
      
      % Same for p, the sizes must match
      p = zeros(size(q));
      p += dataset_P(i,:);
      
      % Second condition is true where the dot product between p and z is higher
      % than the dot product between q and z 
      % Second condition is true where the z height of p is below the z height of q
      second_condition = dot(p,z,2) > dot(q,z,2);
      
      % p is part of P' if it is smaller than EVERY other point in q
      % if "second_condition" only has Ones in it
      if sum(second_condition) == length(second_condition)  
        DTM_points = [DTM_points; dataset_P(i,:)];
      endif
 
    endfor
  
  endfunction

  % Exercise 2 (iii)
  data_sandhausen = load("sandhausen_sample.xyz","ascii");
  % Cant process all points (causing some buffer problems) so we cut the data
  data_sandhausen = data_sandhausen(1:10:length(data_sandhausen),:);
  
  % Approach 1 for grid mesh:
  % Grid derived from data:
  %[X_unsorted, Y_unsorted] = meshgrid(P(:,1),P(:,2));
    
  % We need a sorted meshgrid, we want to connect neighbouring points to a mesh
  % Sort along cols works well for Y
  %Y = sort(Y_unsorted);
  % Sort along cols doesnt work well for X, because X values differ along X
  % So we transpose it first, sort it, and transpose it back
  %X_transposed = transpose(X_unsorted);
  %X_sorted = sort(X_transposed);
  %X = transpose(X_sorted);
  
  % Approach 2:
  % Size of the grid we want:
  x_number_values = 50;
  y_number_values = 50;
  % We need to get the values on the edge of the model
  % Lowest and highest X:
  x_min = min(data_sandhausen(:,1));
  x_max = max(data_sandhausen(:,1));
  % Lowest and highest Y:
  y_min = min(data_sandhausen(:,2));
  y_max = max(data_sandhausen(:,2));
  % Now make x_length values between x_min and x_max as well as for y:
  x_delta = (x_max-x_min)/(x_number_values-1);
  y_delta = (y_max-y_min)/(y_number_values-1);
  x = x_min:x_delta:x_max;
  y = y_min:y_delta:y_max;
  % Now make the desired mesh
  [X, Y] = meshgrid(x,y);
  
    % Making a subplot with 7 graphs, with a Point cloud before DTM as well as
  % a Point cloud after DTM and as mesh for each of 3 chosen lambda values
  figure(1);
  
  % Plot to compare the result to the point cloud
  subplot(2,2,1);
  scatter3(data_sandhausen(:,1), data_sandhausen(:,2), data_sandhausen(:,3), 10);
  title("Sandhausen Pointcloud before DTM");
  
  % Calculate the DTM pointcloud for each value of lambda and plot it 
  subplot(2,2,2);
  P1 = getDTM(data_sandhausen,0.35);
  scatter3(P1(:,1), P1(:,2), P1(:,3), 10);
  title("Pointcloud after DTM with lambda = 0,35");
 
  subplot(2,2,3);
  P2 = getDTM(data_sandhausen,0.15);
  scatter3(P2(:,1), P2(:,2), P2(:,3), 10);
  title("Pointcloud after DTM with lambda = 0,15");
  
  subplot(2,2,4);
  P3 = getDTM(data_sandhausen,0.06);
  scatter3(P3(:,1), P3(:,2), P3(:,3), 10);
  title("Pointcloud after DTM with lambda = 0,06");
  
  % The result now as a mesh model by converting the actual x,y values into
  % the grid's resolution and interpolating the correspondong z values
  figure(2);
  Z = griddata(P1(:,1),P1(:,2),P1(:,3),X,Y);
  surf(X,Y,Z);
  title("DTM mesh with lambda = 0.35");
  
  figure(3);
  Z = griddata(P2(:,1),P2(:,2),P2(:,3),X,Y);
  surf(X,Y,Z);
  title("DTM mesh with lambda = 0.15");
   
  figure(4);
  Z = griddata(P3(:,1),P3(:,2),P3(:,3),X,Y);
  surf(X,Y,Z);
  title("DTM mesh with lambda = 0.06");

endfunction
