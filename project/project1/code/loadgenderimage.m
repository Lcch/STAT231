function [male_data, female_data, unknown_data, male_lm, female_lm, unknown_lm] = loadgenderimage()
    % load gender dataset
    cnt = 0;
    female_data = [];
    for i = 0 : 84
        filename = sprintf('./female_face/face%03d.bmp', i);
        A = imread(filename);
        cnt = cnt + 1;
        female_data(cnt, :) = reshape(A, 1, size(A, 1) * size(A, 2));
    end 
    cnt = 0;
    female_lm = [];
    for i = 0 : 84
        fileID = fopen(sprintf('./female_landmark_87/face%03d_87pt.txt', i));
        cnt = cnt + 1;
        inv = fscanf(fileID, '%f', 2 * 87)';
        female_lm(cnt, :) = [inv([1:87]*2 - 1), inv([1:87]*2)];
        fclose(fileID);
    end
    
    male_data = [];
    cnt = 0;
    for i = 0 : 88
        if (i == 57) continue; end
        filename = sprintf('./male_face/face%03d.bmp', i);
        A = imread(filename);
        cnt = cnt + 1;
        male_data(cnt, :) = reshape(A, 1, size(A, 1) * size(A, 2));
    end
    cnt = 0;
    male_lm = [];
    for i = 0 : 88
        if (i == 57) continue; end
        fileID = fopen(sprintf('./male_landmark_87/face%03d_87pt.txt', i));
        cnt = cnt + 1;
        inv = fscanf(fileID, '%f', 2 * 87)';
        male_lm(cnt, :) = [inv([1:87]*2 - 1), inv([1:87]*2)];
        fclose(fileID);
    end
    
    unknown_data = [];
    cnt = 0;
    for i = 0 : 3
        filename = sprintf('./unknown_face/face%03d.bmp', i);
        A = imread(filename);
        cnt = cnt + 1;
        unknown_data(cnt, :) = reshape(A, 1, size(A, 1) * size(A, 2));
    end
    cnt = 0;
    unknown_lm = [];
    for i = 0 : 3
        fileID = fopen(sprintf('./unknown_landmark_87/face%03d_87pt.txt', i));
        cnt = cnt + 1;
        inv = fscanf(fileID, '%f', 2 * 87)';
        unknown_lm(cnt, :) = [inv([1:87]*2 - 1), inv([1:87]*2)];
        fclose(fileID);
    end
end