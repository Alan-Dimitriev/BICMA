%PATH828: Mini-Assignment 3
%Alan Dimitriev - 20062431
function return_boolean = MarkLowCounts(input_matrix, Q)

    %Check to ensure input matrix is valid
    if  isempty(input_matrix) || class(input_matrix) ~= "double"
        error("Invalid input matrix.")
    end

    %Check to ensure input Q is valid
    if  ~isnumeric(Q) || Q > 1 || Q < 0
        error("Invalid Q value.")
    end
    
    %Compute overall threshold quantile
    threshold = quantile(input_matrix, Q, 'all');
    
    %Determine matrix dimensions
    matrix_size = size(input_matrix);
    
    %Initialize return vector
    return_boolean = zeros(1,matrix_size(1));
    
    
    %Iterate through rows to see if samples go above Q threshold
    for x = 1:matrix_size(1)
        bool_flag = true;
        for y = 1:matrix_size(2)
            if input_matrix(x,y) > threshold
                bool_flag = false;
            end
        end
       
        return_boolean(x) = bool_flag;
    end

end
