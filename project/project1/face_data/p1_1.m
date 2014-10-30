function [  ] = p1_1(X_training, X_test) 
    r = 256;
    c = 256;
    
    [mean_face, U, D] = myPCA(X_training);
    
    % show mean face
    figure()
    imshow(reshape(uint8(mean_face), r, c));
    print(gcf, '-djpeg', '.\part1\a\mean_face.jpg');
    close all;
    
    % show first 20 eigen faces
    n_pca = 20;
    figure()
    for i = 1 : n_pca
        subplot(4, 5, i);
        imshow(reshape(uint8(U(:, i)' + mean_face), r, c));
    end
    print(gcf, '-djpeg', '.\part1\a\first20eigenface.jpg');
    close all;
    
    % normalize eigen faces
    U = normc(U);
    
    % reconstruct face by first 20 eigen faces
    [rec_data] = Reconstruct(mean_face, X_test, U, n_pca);
    figure()
    for i = 1 : size(rec_data, 1)
        subplot(5, 6, i);
        imshow(reshape(uint8(rec_data(i, :)), r, c));
    end
    print(gcf, '-djpeg', '.\part1\a\reconstrustface.jpg');
    close all;
    
    % calculate reconstructerror plot
    figure()
    sum_error = ReconstructError(mean_face, X_test, U);
    plot(sum_error);
    print(gcf, '-djpeg', '.\part1\a\reconstructerror.jpg');
    close all;
end