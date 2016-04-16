function u = coefficient_of_agreement(C)
% -------------------------------------------------------------------------
%   Description:
%       function to calculate the kendall coefficient of agreement
%
%   Input:
%       - C: N x N winning matrix, C(i, j) is the number of times that i beats j
%
%   Output:
%       - u: Kendall coefficient of agreement
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

    num_method = size(C, 1);
    num_user = round(sum(C(:)) / nchoosek(num_method, 2) );

    C = C(:);
    C = C( C > 1 ); % avoid nchoosek(0, 2) and nchoosek(1, 2)
    
    w = 0;
    for i = 1:length(C)
        w = w + nchoosek(C(i), 2);
    end
    
    u = (2 * w) / ( nchoosek(num_method, 2) * nchoosek(num_user, 2) ) - 1;
    
    
end