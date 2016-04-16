
x_dataset = 'uniform'; y_dataset = 'real'; 
% x_dataset = 'nonuniform'; y_dataset = 'real'; 
% x_dataset = 'uniform'; y_dataset = 'nonuniform'; 


%% Load list
list_filename = fullfile('list', 'method.txt');
method = load_list(list_filename);
num_method = length(method);


%% X-dataset

% load votes
vote_filename = fullfile('votes', sprintf('votes_%s_balance_all.csv', x_dataset));
M = csvread(vote_filename, 1, 0); % offset the first row to skip header

% convert M to winning matrix
W = construct_winning_matrix(M, num_method);

% compute BT scores
score = BT_EM_exp(W);
    
% avoid Nan and Inf when compute mean
s = score;
s = s(s == s); % remove NaN
s = s(s ~= Inf); % remove Inf
    
% normalize to zero mean
x_score = score - mean(s);


%% Y-dataset

% load votes
vote_filename = fullfile('votes', sprintf('votes_%s_balance_all.csv', y_dataset));
M = csvread(vote_filename, 1, 0); % offset the first row to skip header

% convert M to winning matrix
W = construct_winning_matrix(M, num_method);

% compute BT scores
score = BT_EM_exp(W);
    
% avoid Nan and Inf when compute mean
s = score;
s = s(s == s); % remove NaN
s = s(s ~= Inf); % remove Inf
    
% normalize to zero mean
y_score = score - mean(s);



%% plot

[color, marker, line_style] = color_spec;

figure;hold on;
for i = 1:length(method)

    plot(x_score(i), y_score(i), marker{i}, 'MarkerFaceColor', color{i}, ...
         'MarkerEdgeColor', color{i}*0.5, 'MarkerSize', 15);
    
end
% legend(method{1}, method{2}, method{3}, method{4}, method{5}, ...
%       method{6}, method{7}, method{8}, method{9}, method{10}, ...
%       method{11}, method{12}, method{13}, method{14});

t = -2:0.1:2;
plot(t, t, '--k');
xlabel(x_dataset);
ylabel(y_dataset);

h = gca;
h.FontName = 'Times New Roman';
h.FontSize = 24;
hold off;

% saveas(h, output_filename);
% fprintf('Save %s\n', output_filename);
