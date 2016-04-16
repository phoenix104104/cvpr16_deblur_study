function u = coefficient_of_agreement(W)
    
    num_method = size(W, 1);
    num_user = round(sum(W(:)) / nchoosek(num_method, 2) );

    W = W(:);
    W = W( W > 0 );
    
    sigma = 0;
    for i = 1:length(W)
        if( W(i) > 1 ) % assume nchoosek(1, 2) = 0
            sigma = sigma + nchoosek(W(i), 2);
        end
    end
    
    u = (2 * sigma) / ( nchoosek(num_method, 2) * nchoosek(num_user, 2) ) - 1;
    
    
end