function [] = p1_4(X_training, X_test, L_training, L_test)
    r = 256;
    c = 256;
    num_lm = 87;
    
    for i = 1 : size(X_training, 1)
        filename = strcat('.\part1\c\warpedface', int2str(i),'.jpg');
        wf_training(i, :) = double(reshape(imread(filename), 1, r*c));
    end
    
    % pca for wrapped face and landmarks
    [mean_wf, U_wf, D_wf] = myPCA(wf_training);
    U_wf = normc(U_wf);
    [mean_lm, U_lm, D_lm] = myPCA(L_training);
    U_lm = normc(U_lm);
    
    n_pca = 10;
    num_of_rf = 20;
    
    % random 20 faces
    ran_wf = zeros(num_of_rf, size(X_training, 2));
    ran_lm = zeros(num_of_rf, size(L_training, 2));
    for i = 1 : num_of_rf
        for j = 1 : n_pca
            ran_wf_e = normrnd(0.0, 1.0) * sqrt(D_wf(j) / 150.0);
            ran_lm_e = normrnd(0.0, 1.0) * sqrt(D_lm(j) / 150.0);
            ran_wf(i, :) = ran_wf(i, :) + ran_wf_e * U_wf(:, j)';
            ran_lm(i, :) = ran_lm(i, :) + ran_lm_e * U_lm(:, j)';
        end
        ran_wf(i, :) = ran_wf(i, :) + mean_wf;
        ran_lm(i, :) = ran_lm(i, :) + mean_lm;
    end
    
    % save random faces
    [warped_face] = WarpedImg(ran_wf, ones(num_of_rf, 1) * mean_lm, ran_lm);
    figure();
    for i = 1 : num_of_rf
        subplot(4, 5, i);
        imshow(reshape(uint8(warped_face(i, :)), r, c));
    end
    print(gcf, '-djpeg', '.\part1\d\d_random_face.jpg');
    
end