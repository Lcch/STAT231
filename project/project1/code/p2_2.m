function [] = p2_2(male_data, female_data, unknown_data, male_lm, female_lm, unknown_lm)
    test_data = [male_data(1:10, :); female_data(1:10, :)];
    test_lm = [male_lm(1:10, :); female_lm(1:10, :)];
    male_data = male_data(11:end, :);
    female_data = female_data(11:end, :);
    male_lm = male_lm(11:end, :);
    female_lm = female_lm(11:end, :);
    
    new_d = 10;
    
    % project images and landmarks into lower dimensional spaces by PCA
    all_face = [male_data; female_data];
    [mean_face, U, D] = myPCA(all_face);
    lowD_male_face = ProjectNewDim_PCA(mean_face, male_data, U, new_d);
    lowD_female_face = ProjectNewDim_PCA(mean_face, female_data, U, new_d);
    w = LowD_Fisher(lowD_male_face, lowD_female_face);
    lowD_test_data = ProjectNewDim_PCA(mean_face, test_data, U, new_d);

    % fisher
    all_lm = [male_lm; female_lm];
    [mean_lm, U_lm, D_lm] = myPCA(all_lm);
    lowD_male_lm = ProjectNewDim_PCA(mean_lm, male_lm, U_lm, new_d);
    lowD_female_lm = ProjectNewDim_PCA(mean_lm, female_lm, U_lm, new_d);
    w_lm = LowD_Fisher(lowD_male_lm, lowD_female_lm);
    lowD_test_lm = ProjectNewDim_PCA(mean_lm, test_lm, U_lm, new_d);
    
    % plot 
    figure();
    for i = 1 : size(male_data)
        hold on;
        plot(w' * lowD_male_face(i, :)', w_lm' * lowD_male_lm(i, :)', 'b+');
    end
    for i = 1 : size(female_data)
        hold on;
        plot(w' * lowD_female_face(i, :)', w_lm' * lowD_female_lm(i, :)', 'r+');
    end
    for i = 1 : 10
        hold on;
        plot(w' * lowD_test_data(i, :)', w_lm' * lowD_test_lm(i, :)', 'bo');
    end
    for i = 11 : 20
        hold on;
        plot(w' * lowD_test_data(i, :)', w_lm' * lowD_test_lm(i, :)', 'ro');
    end
    legend('male training', 'female training', 'male test', 'female test');
    
end