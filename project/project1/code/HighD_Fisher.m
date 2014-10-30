function [ w ] = HighD_Fisher(data1, data2)
    % each row in data is an example.
    mean1 = mean(data1);
    mean2 = mean(data2);
    
    C = [data1 - ones(size(data1, 1), 1) * mean(data1); data2 - ones(size(data2, 1), 1) * mean(data2)]';
    [V, D] = eig(C' * C);
    for i = 1 : size(D, 1)
        A(:, i) = C * V(:, i) .* sqrt(D(i, i)) ./ norm(C * V(:, i));
    end
    y = A' * (mean1 - mean2)';
    w = C * (inv(D^2 * V') * y);
    w = w ./ norm(w);
end