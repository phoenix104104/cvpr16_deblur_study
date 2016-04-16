function [list, n] = load_list(list_name)
% -------------------------------------------------------------------------
%   Description:
%       load a list file that each row is in a form of "name number"
%
%   Input:
%       - list_name: file name of the list
%
%   Output:
%       - list: a cell array containing "name" in the first column
%       - n: a vector containing "number" in the second column
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

    f = fopen(list_name);
    if( f == -1 )
        error('%s does not exist!', list_name);
    end
    
    C = textscan(f, '%s %f', 'CommentStyle', '#');
    
    list = C{1};
    n = double(C{2});
    
    fclose(f);
    
end