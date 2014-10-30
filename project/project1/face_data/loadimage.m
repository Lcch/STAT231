function [ training, test, lm_training, lm_test ] = loadimage()
    % load dataset
    cnt = 0;
    data = [];
    for i = 0 : 177
        if (i == 103) continue; end
        filename = sprintf('./face/face%03d.bmp', i);
        A = imread(filename);
        cnt = cnt + 1;
        data(cnt, :) = reshape(A, 1, size(A, 1) * size(A, 2));
    end
    
    training = data(1 : 150, :);
    test = data(151 : 177, :);
    
    landmark = [];
    cnt = 0;
    for i = 0 : 177
        if (i == 103) continue; end
        fileID = fopen(sprintf('./landmark_87/face%03d_87pt.dat', i));
        fscanf(fileID, '%d', 1);
        cnt = cnt + 1;
        inv = fscanf(fileID, '%f', 2 * 87)';
        landmark(cnt, :) = [inv([1:87]*2 - 1), inv([1:87]*2)];
        fclose(fileID);
    end
    lm_training = landmark(1 : 150, :);
    lm_test = landmark(151 : 177, :, :);
end