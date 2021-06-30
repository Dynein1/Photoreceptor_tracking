function [ out ] = diffhigh( matrix, offset )
matrix_1 = matrix(:,(offset+1):size(matrix,1));
    matrix_2 = matrix(:, 1:(size(matrix,1)-offset));
    out = matrix_1 - matrix_2;
end