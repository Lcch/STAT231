function [ w ] = LowD_Fisher(data1, data2)
    % each column in data is an example.
    % traditional fisher method
    mean1 = mean(data1);
    mean2 = mean(data2);
    n1 = size(data1, 1);
    n2 = size(data2, 1);
    S1 = zeros(size(data1, 2));
    S2 = zeros(size(data2, 2));
    for i = 1 : n1
        x = data1(i, :) - mean1;
        S1 = S1 + x' * x;
    end
    for i = 1 : n2
        x = data2(i, :) - mean2;
        S2 = S2 + x' * x;
    end
    w = inv(S1 + S2) * (mean1 - mean2)';
    w = w ./ norm(w);
end