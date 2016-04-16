
dataset = 'real';
% dataset = 'uniform';
% dataset = 'nonuniform';

attribute = {};
attribute{end+1} = 'manmade';
attribute{end+1} = 'natural';
attribute{end+1} = 'people';
attribute{end+1} = 'saturated';
attribute{end+1} = 'text';
attribute{end+1} = 'all';

num_method = 14; % total number of evaluated methods

fprintf(' %10s | %10s | %8s\n', 'dataset', 'attribute', 'kendall');
fprintf('------------------------------------\n')

for a = 1:length(attribute)
    
    %% load votes
    vote_filename = fullfile('votes', sprintf('votes_%s_balance_%s.csv', dataset, attribute{a}));
    M = csvread(vote_filename, 1, 0); % offset the first row to skip header

    %% convert M to winning matrix
    W = construct_winning_matrix(M, num_method);

    %% compute kendall coefficient of agreement
    k = coefficient_of_agreement(W);
    fprintf(' %10s | %10s | %f\n', dataset, attribute{a}, k);
    
end