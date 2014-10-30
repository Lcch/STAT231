function [  ] = p1_3(X_training, X_test, L_training, L_test) 
    r = 256;
    c = 256;
    num_landmark = 87;
    
    n_training = size(L_training, 1);
    mean_lm = mean(L_training);
    
    % pre-process warpImage of training and test faces
    %{
    warped_face = WarpedImg(X_training, L_training, ones(n_training, 1) * mean_lm);
    size(warped_face);
    for i = 1 : n_training
        figure()
        imshow(reshape(uint8(warped_face(i, :)), r, c));
        filename = strcat('.\part1\c\warpedface', int2str(i),'.jpg');
        print(gcf, '-djpeg', filename);
        close all;
    end
    warped_face = WarpedImg(X_test, L_test, ones(size(X_test, 1), 1) * mean_lm);
    for i = 1 : size(X_test, 1)
        figure()
        imshow(reshape(uint8(warped_face(i, :)), r, c));
        filename = strcat('.\part1\c\warpedface_test', int2str(i),'.jpg');
        print(gcf, '-djpeg', filename);
        close all;
    end
    %}
    
    % load warpedface
    for i = 1 : n_training
        filename = strcat('.\part1\c\warpedface', int2str(i),'.jpg');
        wf_training(i, :) = double(reshape(imread(filename), 1, r*c));
    end
    
    % pca for wrapped faces
    [mean_wf, U_wf, D] = myPCA(wf_training);  
    n_pca = 10;
    figure()
    for i = 1 : n_pca
        subplot(3, 4, i);
        imshow(reshape(uint8(U_wf(:, i)' + mean_wf), r, c));
    end
    print(gcf, '-djpeg', '.\part1\c\eigenface_wf.jpg');
    close all;   
    U_wf = normc(U_wf);
    
    % pca for landmarks
    [mean_lm, U_lm, D] = myPCA(L_training); 
    U_lm = normc(U_lm);
    
    % reconstruct
    [rec_lm] = Reconstruct(mean_lm, L_test, U_lm, n_pca) ;
    wf_test = double(WarpedImg(X_test, rec_lm, ones(size(X_test, 1), 1) * mean_lm));
    [rec_wf_test] = Reconstruct(mean_wf, wf_test, U_wf, n_pca);
    rec_test = WarpedImg(rec_wf_test, ones(size(X_test, 1), 1) * mean_lm, rec_lm);
    
    % show differences between reconstructed faces and original faces
    figure()
    for i = 1 : size(rec_test, 1)
        tm = mod(i,2);
        if (tm == 0) tm = 2; end;
        subplot(2, 2, tm*2-1);
        imshow(reshape(uint8(rec_test(i, :)), r, c));
        subplot(2, 2, tm*2);
        imshow(reshape(uint8(X_test(i, :)), r, c));
        if (tm == 2 )
            print(gcf, '-djpeg', strcat('.\part1\c\c_rec_face_wf', int2str(i/2), '.jpg'));
            close all;
        end;
    end
    
    % calculate reconstruct error plot
    [mean_wf, U_wf, D] = myPCA(wf_training); 
    U_wf = normc(U_wf);
    [mean_lm, U_lm, D] = myPCA(L_training);
    U_lm = normc(U_lm);
    
    dim = size(X_test, 2);
    sum_error = zeros(1, 150)
    for k = 1 : 150
        error = 0.0;
        [rec_lm] = Reconstruct(mean_lm, L_test, U_lm, 10);
        wf_test = WarpedImg(X_test, L_test, ones(size(X_test, 1), 1) * mean_lm);
        [rec_wf_test] = Reconstruct(mean_wf, wf_test, U_wf, k);
        rec_test = WarpedImg(rec_wf_test, ones(size(X_test, 1), 1) * mean_lm, rec_lm);
        for i = 1 : size(rec_test, 1)
            sum_error(k) = sum_error(k) + sum((rec_test(i, :) - X_test(i, :)).^2) / dim;
        end
        sum_error(k) = sum_error(k) / 27.0;
    end
    
    figure()
    plot(sum_error);
    print(gcf, '-djpeg', '.\part1\c\rc_wf_error.jpg');
    close all;
end