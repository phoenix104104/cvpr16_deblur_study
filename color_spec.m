function [color, marker, line_style] = color_spec()
% -------------------------------------------------------------------------
%   Description:
%       return color information to plot figures in our paper
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

color = {};                             marker = {};            line_style = {};
color{end+1} = [1, 0.5, 39/255];        marker{end+1} = 'o';    line_style{end+1} = '--';
color{end+1} = [0, 1, 0];               marker{end+1} = 'o';    line_style{end+1} = '--';
color{end+1} = [136/255, 0, 21/255];    marker{end+1} = 'o';    line_style{end+1} = '--';
color{end+1} = [1, 0, 1];               marker{end+1} = 'o';    line_style{end+1} = '--';
color{end+1} = [0, 0, 1];               marker{end+1} = 'o';    line_style{end+1} = '--';
color{end+1} = [1, 0, 0];               marker{end+1} = 'o';    line_style{end+1} = '--';
color{end+1} = [0, 162/255, 232/255];   marker{end+1} = 'o';    line_style{end+1} = '--';

color{end+1} = [1, 0.5, 39/255];        marker{end+1} = 's';    line_style{end+1} = '-';
color{end+1} = [0, 1, 0];               marker{end+1} = 's';    line_style{end+1} = '-';
color{end+1} = [136/255, 0, 21/255];    marker{end+1} = 's';    line_style{end+1} = '-';
color{end+1} = [1, 0, 1];               marker{end+1} = 's';    line_style{end+1} = '-';
color{end+1} = [0, 0, 1];               marker{end+1} = 's';    line_style{end+1} = '-';
color{end+1} = [1, 0, 0];               marker{end+1} = 's';    line_style{end+1} = '-';
color{end+1} = [0, 162/255, 232/255];   marker{end+1} = 's';    line_style{end+1} = '-';