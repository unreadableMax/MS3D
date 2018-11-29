function A1_exercises
  function C = multiply_matrices_3loops(A,B)
    
    M=size(A)(1);
    N=size(A)(2);
    O=size(B)(2);
    
    C = zeros(M,O);
    
    
    if N != size(B)(1)
      disp("dimensions of matrices do not fit")
      return
    endif
    
    # A*B:
    for m=1:M
        for o=1:O
            # computing one matrix element with a loop:
            for n=1:N
              C(m,o)+=A(m,n)*B(n,o);
            endfor
        endfor
    endfor
    
  endfunction

  function C = multiply_matrices_2loops(A,B)
        
    M=size(A)(1);
    N=size(A)(2);
    O=size(B)(2);
    C = zeros(M,O);
      
    if N != size(B)(1)
      disp("dimensions of matrices do not fit")
      return
    endif
    
    
    for m=1:M
        for o=1:O
            # building the scalar product by hand, but only in one lines
            C(m,o)=sum(A(m,:).*B(:,o).');
        endfor
    endfor
    
    endfunction
        
  function C = multiply_matrices_noloops(A,B)
        C=A*B;  
  endfunction
    
  function [t,C_multiplyWith3Loops,C_multiplyWith2Loops,C_multiplyWithoutLoops] = measure_execution_times(A,B)
    t=zeros(3,1);
    
    tic;
    C_multiplyWith3Loops=multiply_matrices_3loops(A,B);
    t(1) = toc;
    
    tic;
    C_multiplyWith2Loops=multiply_matrices_2loops(A,B);
    t(2) = toc;
    
    tic;
    C_multiplyWithoutLoops=multiply_matrices_noloops(A,B);
    t(3) = toc;
  endfunction
  
  
  # init stuff:
  s=2:3:50; #calculating with s times s (sxs) matrices
  
  timeresults=zeros(3,size(s)(2));
  
  #could compare matrices like this: max(max(abs(A-B))
  errors=zeros(1,size(s)(2));
  
  for i=1:size(s)(2)
    
      N=s(i);
      M=s(i);
      O=s(i);
      A=rand(M,N);
      B=rand(N,O);
      [timeresults(:,i),C_3loops,C_2loops,C_noloops]=measure_execution_times(A,B);
      
      #compare results of 3loop-matrix (C_3loops) and noloop-matrix(C_noloops)
      # what is the maximum differenz between them?
      diff_C_3loops_C_noloops = max(max(abs(C_noloops-C_3loops)));
      
      #compare results of 2loop-matrix (C_2loops) and noloop-matrix(C_noloops)
      diff_C_2loops_C_noloops = max(max(abs(C_noloops-C_2loops)));
      
      errors(i)= max([diff_C_3loops_C_noloops,diff_C_2loops_C_noloops]);
      
  endfor
  
  subplot(1, 2, 1)
  plot(s,timeresults(:,:));
  xlabel ("Sizes of multiplied matrices");
  ylabel ("time in seconds");
  legend("3 loops","2 loops","no loops");
  
  subplot (1, 2, 2)
  plot(s,errors);
  xlabel("Size of multiplied matrices");
  ylabel ("Highest difference between all results");
  
endfunction