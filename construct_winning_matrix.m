function C = construct_winning_matrix(M, num_method)
% -------------------------------------------------------------------------
%   Description:
%       function to construct a winning matrix C ftom vote matrix M
%
%   Input:
%       - M: N x 4 vote matrix, N is the number of images
%            M(i, 1) is image id
%            M(i, 2) is method1 id
%            M(i, 3) is method2 id
%            M(i, 4) is compared result, 1 if user chooses method1, 2 if user chooses method2
%
%       - num_method: the number of evaluated methods
%
%   Output:
%       - C: winning matrix, C(i, j) is the number of times that user choose i over j
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

    C = zeros(num_method, num_method);
    
    for i = 1:size(M, 1)

        img_id  = M(i, 1);
        method1 = M(i, 2);
        method2 = M(i, 3);
        result  = M(i, 4);

        if( result == 1 )
            C(method1, method2) = C(method1, method2) + 1;
        elseif( result == 2 )
            C(method2, method1) = C(method2, method1) + 1;
        end

    end

end