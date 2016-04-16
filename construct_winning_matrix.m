function W = construct_winning_matrix(M, num_method)

    W = zeros(num_method, num_method);
    for i = 1:size(M, 1)

        img_id  = M(i, 1);
        method1 = M(i, 2);
        method2 = M(i, 3);
        result  = M(i, 4);

        if( result == 1 )
            W(method1, method2) = W(method1, method2) + 1;
        elseif( result == 2 )
            W(method2, method1) = W(method2, method1) + 1;
        end

    end

end