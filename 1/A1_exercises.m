function A1_exercises
  function C = multiply_matrices_3loops(A,B)
    if size(A)(2) != size(B)(1)
      disp("cant multiply because size(A)(2) != size(B)")
      return
    endif
    
    M=size(A)(1);
    N=size(A)(2);
    O=size(B)(2);
    C = zeros(M,O);
    
    for m=1:M
        for o=1:O
            for n=1:N
              C(m,o)+=A(m,n)*B(n,o);
            endfor
        endfor
    endfor
    
  endfunction

  function C = multiply_matrices_2loops(A,B)
        
    if size(A)(2) != size(B)(1)
      disp("cant multiply because size(A)(2) != size(B)")
      return
    endif
    
    M=size(A)(1);
    N=size(A)(2);
    O=size(B)(2);
    
    C = zeros(M,O);
    
    for m=1:M
        for o=1:O
            #there are two options to do this:
            C(m,o)=sum(A(m,:).*B(:,o).');
            #C(m,o)=A(m,:)*B(:,o);
        endfor
    endfor
    endfunction
        
  function C = multiply_matrices_noloops(A,B)
        C=A*B;  
  endfunction
    
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
  s=2:20; #calculating with s times s (sxs) matrices
  
  timeresults=zeros(3,size(s)(2));
  
  #could compare matrices like this: max(max(abs(A-B))
  max_diff=zeros(1,size(s)(2));
  
  for i=1:size(s)(2)
      s(i)
      N=s(i);
      M=s(i);
      O=s(i);
      A=rand(M,N)*10;
      B=rand(N,O)*10;
      [timeresults(:,i),C3,C2,C0]=measure_execution_times(A,B);
      
      #compare results of 3loop-matrix (C3) and noloop-matrix(C0)
      # what is the maximum differenz between them?
      diff_c3_c0 = max(max(abs(C0-C3)));
      
      #compare results of 2loop-matrix (C2) and noloop-matrix(C0)
      diff_c2_c0 = max(max(abs(C0-C2)));
      
      max_diff(i)= max([diff_c3_c0,diff_c2_c0]);
      
  endfor
  
  subplot(1, 2, 1)
  plot(s,timeresults(:,:));
  xlabel ("Size, S, of multiplied matrices, SxS");
  ylabel ("Computing time in seconds");
  legend("3 loops","2 loops","no loops");
  
  subplot (1, 2, 2)
  plot(s,max_diff);
  xlabel("Size of multiplied matrices");
  ylabel ("Highest difference between all results");
  
endfunction