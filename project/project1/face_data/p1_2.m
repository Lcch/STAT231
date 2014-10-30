function [ V, D ] = p1_2(X_training, X_test, L_training, L_test) 
    r = 256;
    c = 256;
    num_landmark = 87;
    
    % get pca of landmarks
    [mean_lm, U, D] = myPCA(L_training);
    mean_face = mean(X_training);
    
    % mean face with mean landmark
    h = figure();
    size(mean_lm)
    imshow(reshape(uint8(mean_face), r, c));
    hold on;
    plot(mean_lm(1:num_landmark), mean_lm(num_landmark+1:num_landmark*2), 'r.', 'MarkerSize', 15);
    hold off;
    print(gcf, '-djpeg', '.\part1\b\b_mean_lm.jpg');
    close all;
    
    % first 5 eigen warppings
    figure()
    n_pca = 5
    for i = 1 : n_pca
        u_show = U(:, i)' + mean_lm;
        plot(u_show(1:num_landmark), u_show(num_landmark+1:num_landmark*2), 'r.', 'MarkerSize', 15);
        axis([0 256 0 256]);
        set(gca , 'Ydir', 'reverse');
        print(gcf, '-djpeg', strcat('.\part1\b\b_eigenlm', int2str(i), '.jpg'));
        close all;
    end
    
    U = normc(U);
    
    % reconstruct landmarks by 5 eigen landmarks and show the differences
    [rec_data] = Reconstruct(mean_lm, L_test, U, n_pca);
    figure()
    for i = 1 : size(X_test, 1)
        tm = mod(i,2);
        if (tm == 0) tm = 2; end;
        subplot(2,2,tm*2-1)
        imshow(reshape(uint8(X_test(i,:)), r, c));
        hold on;
        u_show = rec_data(i, :);
        plot(u_show(1:num_landmark), u_show(num_landmark+1:num_landmark*2), 'r.', 'MarkerSize', 10);
        set(gca , 'Ydir','reverse');
        hold off;
        subplot(2,2,tm*2)
        imshow(reshape(uint8(X_test(i,:)), r, c));
        hold on;
        u_show = L_test(i, :);
        plot(u_show(1:num_landmark), u_show(num_landmark+1:num_landmark*2), 'r.', 'MarkerSize', 10);
        set(gca , 'Ydir','reverse');
        hold off;
        if (tm == 2)
            print(gcf, '-djpeg', strcat('.\part1\b\b_com_face_lm', int2str(i/2), '.jpg'));
            close all;
        end
    end
    
    % reconstructerror 
    figure()
    sum_error = ReconstructError(mean_lm, L_test, U, 'p2');
    plot(sum_error);
    print(gcf, '-djpeg', '.\part1\b\b_reconstructerror_lm.jpg');
    close all;
end