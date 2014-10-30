function [sum_error] = ReconstructError(mean_face, test, U, func)
    % calculate the reconstructerror over k which is the number of 
    % eigen vectors of using for reconstruction.
    n = size(U, 2);
    dim = size(U, 1);
    sum_error = zeros(1, size(U, 2));
    for i = 1 : size(test, 1)
        x = test(i, :) - mean_face;
        rec_x = zeros(1, dim);
        for j = 1 : n
            rec_x = rec_x + x * U(:, j) * U(:, j)';
            % problem 1 and problem2 have different distance calculation
            % method
            if (strcmp(func, 'p2'))
                dd = (x - rec_x).^2;
                dis = dd(1:87) + dd(88:87*2);
                sum_error(j) = sum_error(j) + sum(sqrt(dis)) / 87.0;
            else
                sum_error(j) = sum_error(j) + sum((x - rec_x).^2) / dim;
            end
        end
    end
    sum_error = sum_error ./ size(test, 1);
end