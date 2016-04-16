function score = BT_EM_exp(C)
% -------------------------------------------------------------------------
%   Description:
%       function to calculate BT scores from a winning matrix C
%       assume P_ij = exp(s_i) / ( exp(s_i) + exp(s_j) ) and likelihood P = (P_ij)^C_ij
%       please check BT_scores.pdf for more details
%
%   Input:
%       - C: N x N winning matrix, C(i, j) is the number of times that i beats j
%
%   Output:
%       - score: N scores
%
%   Citation: 
%       A Comparative Study for Single Image Blind Deblurring
%       Wei-Sheng Lai, Jia-Bin Huang, Zhe Hu, Narendra Ahuja, and Ming-Hsuan Yang
%       IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2016
%
%   Contact:
%       Wei-Sheng Lai
%       wlai24@ucmerced.edu
%       University of California, Merced
% -------------------------------------------------------------------------
    
    N = C + C'; % N(i, j) = C(i, j) + C(j, i): the number of comparison between i and j
    
    iter_max = 5000;
    precision = 1e-8;
    
    n = size(N, 1);
    s = ones(size(N, 1), 1);
    
    delta = realmax;
    iter = 0;
    
    while( norm(delta) > precision && iter < iter_max )

        L       = repmat(exp(s)', n, 1) + repmat(exp(s), 1, n);
        s_next  = log( sum(C, 2) ./ sum(N ./ L, 2) );
        delta   = s_next - s;
        s       = s_next;
        iter    = iter + 1;
        
    end
    
    score = s;
    
end
