
dataset = 'real'; plot_title = 'Real';
% dataset = 'uniform'; plot_title = 'Uniform';
% dataset = 'nonuniform'; plot_title = 'Non-Uniform';

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
score_matrix = zeros(num_img, num_method);

for i = 1:num_img
    
    row = find(M(:, 1) == attr_list(i));
    
    % convert M to winning matrix
    W = construct_winning_matrix(M(row, :), num_method);
        
    % compute BT scores
    score = BT_EM_exp(W);
    
    % avoid Nan and Inf when compute mean
    s = score;
    s = s(s == s); % remove NaN
    s = s(s ~= Inf); % remove Inf
    
    % normalize to zero mean
    score = score - mean(s);
    score_matrix(i, :) = score';
    
end


%% compute mean scores for each method
method_score = zeros(num_method, 1);
for i = 1:num_method
    s = score_matrix(:, i);
    s = s(s == s); % remove NaN
    s = s(s ~= Inf); % remove Inf
    method_score(i) = mean(s);
end

%% sort methods by mean scores
[~, order] = sort(method_score, 'descend');


%% plot cumulative frequency
[color, marker, line_style] = color_spec;

figure; hold on;
select_method = order(1:14);
legend_cmd = 'legend(';

x = -5:0.5:10;
for i = 1:length(select_method)
    m = select_method(i);
    s = score_matrix(:, m);
    s = s(s == s); % remove NaN
    s = s(s ~= Inf);  % remove Inf
    
    y = histc(s, x);
    z = cumsum(y)/sum(y);
    h = plot(x, z, 'LineWidth', 2);
    h.Color = color{m};
    h.LineStyle = line_style{m};
    
    legend_cmd = sprintf('%s method{%d}', legend_cmd, select_method(i));
    if( i < length(select_method) )
        legend_cmd = sprintf('%s, ', legend_cmd);
    end
end
legend_cmd = sprintf('%s);', legend_cmd);
l = eval(legend_cmd);
l.FontSize = 16;
l.Location = 'southeast';

if( strcmp(attribute, 'manmade') )
    title(sprintf('%s (man-made)', plot_title));
else
    title(sprintf('%s (%s)', plot_title, attribute));
end
xlabel('B-T Scores');
ylabel('Cumulative Frequency');

h = gca;
h.FontName = 'Times New Roman';
h.FontSize = 24;

hold off;

%% save results

% filename = sprintf('bt_cdf_%s_%s.pdf', dataset, attribute);
% saveas(h, filename);
% fprintf('Save %s\n', filename);
