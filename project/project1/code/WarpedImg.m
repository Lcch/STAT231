function [warped_data] = WarpedImg(data, oriMarks, desMarks)   
    % My warpedImg interface to warpImage_kent
    r = 256;
    c = 256;
    num_lm = 87;
    
    for i = 1 : size(data, 1)
        Image = reshape(data(i, :), r, c);
        originalMarks = reshape(oriMarks(i, :), num_lm, 2);
        desiredMarks = reshape(desMarks(i, :), num_lm, 2);
        warped_data(i, :) = reshape(warpImage_kent(Image, originalMarks, desiredMarks), 1, r * c);
    end
    warped_data = double(warped_data);
end