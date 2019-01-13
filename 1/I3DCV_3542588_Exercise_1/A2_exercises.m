function A2_exercises
  
  % Exercise (i) Using for loops only
  function distance = closest_points_with_loops(A,B)
    
      # We want to calculate the distance between two Vectors manually
      function dist = calc_dist_by_hand(a,b)
        distance_vector = [ a(1,1)-b(1,1) , a(1,2)-b(1,2) ];
        dist = sqrt(distance_vector(1)^2 + distance_vector(2)^2);
      endfunction
    
      # Extract Vector sizes
      n = size(A)(1);
      m = size(B)(1);
      
      % Get the shortest distance among the distances
      distance=0;
      for n_i = [1:n]
        shortest_dist = calc_dist_by_hand(A(n_i,:),B(1,:));
        for m_i = [2:m]
          current_dist = calc_dist_by_hand(A(n_i,:),B(m_i,:));
          if shortest_dist>current_dist
            shortest_dist = current_dist;
          endif
        endfor
        distance+=shortest_dist;
      endfor
      
  endfunction
  
  % Exercise (ii): Using no loops
  function d=closest_points_noloops(A,B)
  
      % Extract Vector sizes
      n = size(A)(1);
      m = size(B)(1);
      
      % Using Octave functions for tiling and repeating
      B=repmat(B,n,1);
      repIndexY=ones(m,n).*[1:n];
      A=A(repIndexY,:);
      diff=A-B;
      len=sqrt(sum(diff.^2'));
      d=sum(min(reshape(len,m,n)));
      
  endfunction
  
  % Measure execution times of both calculation methods
  function [t,d]=measure_execution_times(A,B)
    
    d = t = zeros(2,1);
    
    tic;
    d(1,1)=closest_points_with_loops(A,B);
    t(1,1)=toc;
    tic
    d(2,1)=closest_points_noloops(A,B);
    t(2,1)=toc;
    
  endfunction
 
  % Main part
  sizes=2:100; 
  timeresults = d = zeros(2,size(sizes)(2));
  d           =  zeros(2,size(sizes)(2));
  
  for i=1:size(sizes)(2)
    
      sizes(i)
      N = M = sizes(i);
      
      % Random point clouds
      A=rand(N,2)*10;
      B=rand(M,2)*10;
      
      % Measure times
      [timeresults(:,i),d(:,i)]=measure_execution_times(A,B);
      
  endfor
  
  % Check if results are more or less equal
  epsilon = 0.00001;
  difference = d(1,:)-d(2,:)
  if epsilon > difference 
    disp("The results are the same")
  else
    disp("The results are not the same")
  endif
  
  figure(1)
  plot(sizes,timeresults(:,:));
  xlabel ("Size of clouds A & B");
  ylabel ("Computing time in seconds");
  legend("3 loops","no loops");
  
  print('A2_measurement_results.png')
  
endfunction