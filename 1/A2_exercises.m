function A2_exercises
  
  function d=closest_points_with_loops(A,B)
    
      #we want to calculate the distance between 2 2dVecs manually:
      function dist = calc_dist_by_hand(a,b)
        distance_vector = [ a(1,1)-b(1,1) , a(1,2)-b(1,2) ];
        dist = sqrt(distance_vector(1)^2 + distance_vector(2)^2);
      endfunction
    
      # cloud A owns n 2d-vecs
      n = size(A)(1);
      
      # clud B owns m 2d-vecs
      m = size(B)(1);
      
      d=0;
      for n_i = [1:n]
        shortest_dist = calc_dist_by_hand(A(n_i,:),B(1,:));
        for m_i = [2:m]
          current_dist = calc_dist_by_hand(A(n_i,:),B(m_i,:));
          if shortest_dist>current_dist
            shortest_dist = current_dist;
          endif
        endfor
        d+=shortest_dist;
      endfor
      
  endfunction
  
  
  function d=closest_points_noloops(A,B)
  
      # cloud A owns n 2d-vecs
      n = size(A)(1);
      
      # clud B owns m 2d-vecs
      m = size(B)(1);
      
      B=repmat(B,n,1);
      
      special_index_vec=ones(m,n).*[1:n];
      A=A(special_index_vec,:);
      
      diff=A-B;
      
      len=sqrt(sum(diff.^2'));
      d=sum(min(reshape(len,m,n)));
      
  endfunction
  
  # executes our 2 functions ans returns the computationtime
  # and result (d) of both functions/computationmethods
  function [t,d]=measure_execution_times(A,B)
    
    d=zeros(2,1);
    t=zeros(2,1);
    
    tic;
    d(1,1)=closest_points_with_loops(A,B);
    t(1,1)=toc;
    
    tic
    d(2,1)=closest_points_noloops(A,B);
    t(2,1)=toc;
    
  endfunction
 
  s=2:1:50; #calculating with s times s (sxs) matrices
  
  timeresults =  zeros(2,size(s)(2));
  d           =  zeros(2,size(s)(2));
  
  for i=1:size(s)(2)
      s(i)
      N=s(i);
      M=s(i);
      A=rand(N,2)*10;
      B=rand(M,2)*10;
      [timeresults(:,i),d(:,i)]=measure_execution_times(A,B);
      
  endfor
  
  
  subplot(1, 2, 1)
  plot(s,timeresults(:,:));
  xlabel ("Size of clouds A & B");
  ylabel ("Computing time in seconds");
  legend("3 loops","no loops");
  
  subplot (1, 2, 2)
  plot(s,d(1,:)-d(2,:));
  xlabel("Size of clouds A & B");
  ylabel ("Difference d1-d2 between both results");
  
endfunction