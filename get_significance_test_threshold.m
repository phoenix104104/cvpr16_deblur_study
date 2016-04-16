function R = get_significance_test_threshold(num_method, num_vote, alpha)
% -------------------------------------------------------------------------
%   Description:
%       function to calculate the threshold for the significance test
%
%   Input:
%       - num_method: the number of evaluated methods
%       - num_vote: the total number of votes
%       - alpha: significance level, default = 0.01
%
%   Output:
%       - R: threshold for the significance test
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

    if( ~exist('alpha', 'var') )
        alpha = 0.01;
    end
    
    M  = num_method;
    S  = ceil(num_vote/nchoosek(M, 2));  % Number of subjects
    N  = 1e7;                 % Number of samples
    D  = randn(M, N);         % Draw random samples
    Dr = max(D) - min(D);     % Compute range in each group

    W_m_alpha = prctile(Dr, 100 * (1 - alpha));  % Compute W_{M, \alpha}

    R = ceil(0.5 * W_m_alpha * sqrt(S * M) + 0.25);


end