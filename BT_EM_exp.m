function score = BT_EM_exp(C)
    
    % assume P_ij = exp(s_i) / ( exp(s_i) + exp(s_j) )
    % likelihood P = (P_ij)^C_ij
    % C: winning matrix, C(i, j) is the number of times that i beats j
    
    N = C + C'; % N(i, j) = C(i, j) + C(j, i): the number of comparison between i and j
    
    n = size(N, 1);
    
    iter = 0;
    iter_max = 5000;
    precision = 1e-8;
    
    
    s = ones(size(N, 1), 1);
    
    delta = realmax;
    
    while( norm(delta) > precision && iter < iter_max )

        L       = repmat(exp(s)', n, 1) + repmat(exp(s), 1, n);
        s_next  = log( sum(C, 2) ./ sum(N ./ L, 2) );
        delta   = s_next - s;
        s       = s_next;
        iter    = iter + 1;
    end
    
    score = s;
    
end
