function [rec_data] = Reconstruct(mean_face, test, U, n_pca)
    % reconstruct dataset by first n_pca eigen vectors
    rec_data = zeros(size(test));
    for i = 1 : size(test, 1)
        x = test(i, :) - mean_face;
        for j = 1 : n_pca
            rec_data(i, :) = rec_data(i, :) + x * U(:, j) * U(:, j)';
        end
        rec_data(i, :) = rec_data(i, :) + mean_face;
    end 
end