function [mean_x, U, D] = myPCA(training)
    % each row is an example data
    % return eigenvectors without normalize
    dim = size(training, 2);
    n_training = size(training, 1);
    mean_x = mean(training);    
    training = training - ones(n_training, 1) * mean_x;
   
    [V, D] = eig(training * training');
    [D, I] = sort(diag(D), 'descend');
    V = V(:, I);
    for i = 1 : n_training
        U(:, i) = training' * V(:, i);
    end
end