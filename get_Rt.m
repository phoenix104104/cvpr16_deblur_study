function Rt = get_Rt(num_method, num_vote, alpha)
    
    if( ~exist('alpha', 'var') )
        alpha = 0.01;
    end
    %t = 15;                   % Number of targets (method of interest)
    t = num_method;
    s = ceil(num_vote/nchoosek(t, 2));  % Number of subjects

    %alpha = 0.01;             % Significance level 
    N = 1e7;                  % Number of samples

    D  = randn(t, N);         % Draw random samples
    Dr = max(D) - min(D);     % Compute range in each group

    Wt_alpha = prctile(Dr, 100*(1-alpha));  % Compute W_{t, \alpha}

    Rt = ceil(0.5*Wt_alpha*sqrt(s*t) + 0.25);


end