%PATH828: Mini-Assignment 1
%Alan Dimitriev - 20062431

%Function that takes a matrix of doubles as input and
%returns the normalized value of each variable based on
%its column sum
function result_matrix = SampleNormalizationRF(x)
    %Check to ensure matrix isn't empty
    if  isempty(x)
        error('Input must be a double matrix, not an empty matrix')
    end
    
    if class(x) == "double"
        %Compute the sum of each column
        column_sums = sum(x);
        %Divide each matrix element by its column sum
        result_matrix = x./column_sums;
    else
        error('Input must be a double, not a %s.', class(x))
    end
end