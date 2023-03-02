%PATH828: Mini-Assignment 2
%Alan Dimitriev - 20062431

function return_vector = SampleCorrelation(input_matrix, input_string)
    %Check to ensure input matrix is valid
    if  isempty(input_matrix) || class(input_matrix) ~= "double"
        error("Invalid input matrix.")
    end
    
    %Check to ensure input string is valid
    if input_string ~= "Spearman" && input_string ~= "Pearson"
        error("Invalid input string.")
    end
    
    %Initialize default return vector
    input_size = size(input_matrix);
    input_columns = input_size(1);
    return_vector = zeros(1, input_columns);
    
    %Find correlation coefficients using designated correlation type
    correlations = corr(input_matrix, "Type", input_string);
    
    %Sum the correlation coefficients, subtracting one to account for
    %individual row's self coefficient
    correlation_sums = sum(correlations) - 1;
    
    %Find the size of the correlation matrix
    corr_size = size(correlations);
    
    %Find the number of rows of the matrix minus one to account for
    %individual row's self coefficient
    num_rows = corr_size(1) - 1;
    
    %Return the average (sum of correlations divided by number of rows)
    return_vector = correlation_sums / num_rows;
    
end