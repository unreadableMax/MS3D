function A2_exercises
 
  clear all; 
  close all;
 
  % Exerise 2 (ii)
  % Let p,q ? P denote two points in a point-cloud P ?R3. 
  % Let ~z = [0,0,-1] be a vector pointing in the direction of the ground. 
  % Let ~g = [1,1,0] be a vector denoting the ground plane. 
  % Let <·,·> denote the the dot product, i.e. projection of a vector. 
  % Let ? be a threshold denoting the amount of detail you want to extract.
  % Then, a point p is in the DTM point-cloud ˆ P only if the following holds.
  % ˆP = {p |?p,q ? P : ||<p,~g> - <q,~g>|| < ? and <p,~z> > <q,~z>}
  function DTM_points = getDTM(dataset_P, detail_threshold_lambda, neighbourhood_radius)
  
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
  
    %"Initializing" ^P 
    DTM_points = [];
  
    % For better understanding...
    x = dataset_P(:,1);
    y = dataset_P(:,2);
  
    % g and z like described in the task
    g = [1,1,0];
    z = [0,0,-1];
    
    % For output of the progress
    next_milestone = length(x)/10;
  
    % We'll check each point p in dataset_P (optimizing later)
    for i=1:length(x)
    
      % p is the point we are currently checking
      p = dataset_P(i,:);
    
      % Get the points with the neighbourhood of p. 
      % We could check every other point as q, but that would be too much i guess
      % Task says this is "closely related to the non-maximum suppression",
      % so let's work with a neighbourhood here
      % "q is from dataset_P where dataset_P.x and dataset_P.y are around p in 
      % a circle with r = neighbourhood_radius
      is_close = ( ((x-p(1)).*(x-p(1)) + (y-p(2)).*(y-p(2)) ) <= neighbourhood_radius*neighbourhood_radius);
      % Remove p from the values
      is_close(i) = 0;
      % Collect neighbourhood
      q = dataset_P( is_close, : );
      
      % Now lets check if the describend conditions hold true for all q
      % is it false for one time, p shall not transferred into DTM_points
      p_is_okay = true;
    
      for j=1:size(q,1)
        % These were our conditions
        first_condition = abs( dot(p,g) - dot(q(j,:),g) ) <= detail_threshold_lambda;
        second_condition = dot(p,z) > dot(q(j,:),z);
      
        % if first condition or second condition is false, not all requirements are met
        if not(first_condition) || not(second_condition)
          % Youre fired, bye
          p_is_okay = false;
        endif
      endfor
    
      % now lets add all p that are okay
      if p_is_okay 
        DTM_points = [DTM_points; p];
      endif
      
      % Just to let know how much the progress is without needing to interrupt 
      % the process by debugging - depending on the parameters the script can take a
      % while
      if i/length(x) > next_milestone
        next_milestone += length(x)/10;
        disp("Progress of processing the DTM:")
        disp(i/(length(x)*100))
      endif
 
    endfor
  
  endfunction

  % Exercise 2 (i)
  data_sandhausen = load("sandhausen_sample.xyz","ascii");
  % Cant process all points (causing some buffer problems) so we cut the data
  data_sandhausen = data_sandhausen(1:10:length(data_sandhausen),:);
  
  % Get the points for the DTM
  lambda = 1.2;
  neighbourhood = 5; %0.5
  P = getDTM(data_sandhausen,lambda,neighbourhood);

  figure(1);
  % Plot to compare the result to the point cloud
  scatter3(data_sandhausen(:,1), data_sandhausen(:,2), data_sandhausen(:,3), 10);
  
  figure(2);
  % The current result as point cloud
  scatter3(P(:,1), P(:,2), P(:,3), 10);
  
  figure(3);
  
  % Approach 1:
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
  x_min = min(P(:,1));
  x_max = max(P(:,1));
  % Lowest and highest Y:
  y_min = min(P(:,2));
  y_max = max(P(:,2));
  % Now make x_length values between x_min and x_max as well as for y:
  x_delta = (x_max-x_min)/(x_number_values-1);
  y_delta = (y_max-y_min)/(y_number_values-1);
  x = x_min:x_delta:x_max;
  y = y_min:y_delta:y_max;
  % Now make the desired mesh
  [X, Y] = meshgrid(x,y);
  
  % The result now as a mesh model by converting the actual x,y values into
  % the grid's resolution and interpolating the correspondong z values
  Z = griddata(P(:,1),P(:,2),P(:,3),X,Y);
  surf(X,Y,Z);

endfunction
