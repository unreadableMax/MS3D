function A1_exercises
  
  % Exercise (i): Loops only
  function C = multiply_matrices_3loops(A,B)
    
    % Checking for matching dimensions
    if size(A)(2) != size(B)(1)
      disp("cant multiply because size(A)(2) != size(B)")
      return
    endif
    
    % Allocating size
    C = zeros(size(A)(1),size(B)(2));
    
    % Making the calculation using scalars 
    for m=1:size(A)(1)
        for o=1:size(B)(2)
            for n=1:size(A)(2)
              C(m,o)+=A(m,n).*B(n,o);
            endfor
        endfor
    endfor
    
  endfunction

  % Exercise (ii): Two Loops, last calculation with Vectors 
  function C = multiply_matrices_2loops(A,B)
        
    % Checking for matching dimensions
    if size(A)(2) != size(B)(1)
      disp("size(A)(2) != size(B)")
      return
    endif
    
    % Allocating size
    C = zeros(size(A)(1),size(B)(2));
    
    % Making the calculation using Vector times Vector 
    for m=1:size(A)(1)
        for o=1:size(B)(2)
            # Row Vector of A times col vector of B
            C(m,o)=sum(A(m,:).*B(:,o).');
        endfor
    endfor
    
  endfunction
  
  % Exercise (iii) No loops
  function C = multiply_matrices_noloops(A,B)
        % Simple matrix * matrix multiplication
        C=A*B;  
  endfunction
  
  % Function to measure times for all three functions
  function [t,C_3loops,C_2loops,C_noloop] = measure_execution_times(A,B)
    t=zeros(3,1);

    tic;
    C_3loops=multiply_matrices_3loops(A,B);
    t(1) = toc;    
    tic;
    C_2loops=multiply_matrices_2loops(A,B);
    t(2) = toc;
    tic;
    C_noloop=multiply_matrices_noloops(A,B);
    t(3) = toc;
    
  endfunction
  
  
  # init stuff:
  # Vector of sizes for the matrices
  sizes = 2:50; 
  # Epsilon to make sure the results are more or less the same
  epsilon = 0.00001; 
  
  timeresults=zeros(3,size(sizes)(2));
  
  #could compare matrices like this: max(max(abs(A-B))
  max_diff=zeros(1,size(sizes)(2));
  
  for i=1:size(sizes)(2)
      sizes(i)
      N = M = O = sizes(i);
      A=rand(M,N)*10;
      B=rand(N,O)*10;
      [timeresults(:,i),C3,C2,C0]=measure_execution_times(A,B);
      
      % Calculate differences ...
      diff_c3_c0 = max(max(abs(C0-C3)));
      diff_c2_c0 = max(max(abs(C0-C2)));   
      % ... and check if they are okay
      if epsilon > max([diff_c3_c0,diff_c2_c0])
        disp("The results are the same")
      else
        disp("The results are not the same")
      endif
      
  endfor
  
  figure(1)
  plot(sizes,timeresults(:,:));
  xlabel ("Size, S, of multiplied matrices, SxS");
  ylabel ("time in seconds");
  legend("3 loops","2 loops","no loops");
  
  print('A1_measurement_results.png')
  
endfunction