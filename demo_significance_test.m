% -------------------------------------------------------------------------
%  Description:
%       Demo script to show grouping results from the significance test
%       This script reproduces the results of Figure 8 in our paper.
%
%  Citation: 
%       A Comparative Study for Single Image Blind Deblurring
%       Wei-Sheng Lai, Jia-Bin Huang, Zhe Hu, Narendra Ahuja, and Ming-Hsuan Yang
%       IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2016
%
%  Contact:
%       Wei-Sheng Lai
%       wlai24@ucmerced.edu
%       University of California, Merced
% -------------------------------------------------------------------------

%% input dataset and attribute
dataset = 'real';
% dataset = 'uniform';
% dataset = 'nonuniform';

attribute = 'all';
% attribute = 'manmade';
% attribute = 'natural';
% attribute = 'people';
% attribute = 'saturated';
% attribute = 'text';


%% Load list
list_filename = fullfile('list', 'method.txt');
method = load_list(list_filename);

attr_filename = fullfile('attributes', sprintf('%s_%s.txt', dataset, attribute));
fprintf('Load %s\n', attr_filename);
attr_list = dlmread(attr_filename);

num_img = length(attr_list);
num_method = 14;


%% load votes
vote_filename = fullfile('votes', sprintf('votes_%s_balance_%s.csv', dataset, attribute));
fprintf('Load %s\n', vote_filename);
M = csvread(vote_filename, 1, 0); % offset the first row to skip header


%% build winning matrix
W = construct_winning_matrix(M, num_method);
        

%% compute R-threshold
num_vote = sum(W(:));
alpha = 0.01;
R_thr = get_Rt(num_method, num_vote, alpha);
fprintf('R_thr = %d\n', R_thr);


%% use #vote as score
score = sum(W, 2);
[score_sort, order_sort] = sort(score, 'descend');

%% grouping
group_list = {};
for i = 1:length(order_sort)
    
    method1 = order_sort(i);
    group = method1;
    
    for j = i+1:length(order_sort)
        method2 = order_sort(j);
        if( abs( score( method1 ) - score( method2 ) ) < R_thr )
            group(end+1) = method2;
        else
            break;
        end
    end
    group_list{end+1} = group;
    
end


%% merge groups
select_group_id = [];
for i = length(group_list):-1:2
    
    curr_group = group_list{i};
    search_group = group_list{i-1};
        
    is_a_group = false;
    for u = 1:length(curr_group)
        if( sum(curr_group(u) == search_group) == 0 )
            is_a_group = true;
            break;
        end
    end
        
    if( is_a_group )
        select_group_id(end+1) = i;
    end
    
    
end
select_group_id(end+1) = 1;

select_group_id = sort(select_group_id);
group_list = group_list(select_group_id);

%% results
fprintf('Grouping results:\n');
fprintf(' %12s | %s\n', 'Method', '#votes');
fprintf('-----------------------\n')
for i = 1:length(group_list)
    group = group_list{i};
    for j = 1:length(group)
        fprintf(' %12s | %6d\n', method{group(j)}, score(group(j)));
    end
    fprintf('-----------------------\n')
end