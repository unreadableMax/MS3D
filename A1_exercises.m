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
            C(m,o)=sum(A(m,:).*B(:,o).');
            #C(m,o)=sum(A(m,:)B(:,o));
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
  
  #can compare matrices like this: mean(mean(abs(A-B))
  mean_errors=zeros(3,size(s)(2));
  
  for i=1:size(s)(2)
      s(i)
      N=s(i);
      M=s(i);
      O=s(i);
      A=rand(M,N)*10;
      B=rand(N,O)*10;
      [timeresults(:,i),c3,c2,c0]=measure_execution_times(A,B);
  endfor
  
  plot(s,timeresults(:,:))
  
  



endfunction