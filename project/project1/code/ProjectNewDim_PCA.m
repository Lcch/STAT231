function [rec_data] = ProjectNewDim_PCA(mean_face, test, U, n_pca)
    % project data into lower spaces using eigen vectors of PCA
    rec_data = zeros(size(test, 1), n_pca);
    for i = 1 : size(test, 1)
        x = test(i, :) - mean_face;
        for j = 1 : n_pca
            rec_data(i, j) = U(:, j)' * x';
        end
    end 
end