function [] = p2_1(male_data, female_data, unknown_data)
    test_data = [male_data(1:10, :); female_data(1:10, :)];
    male_data = male_data(11:end, :);
    female_data = female_data(11:end, :);
  
    % method I: calculate fisher directly by following instruction
    w = HighD_Fisher(male_data, female_data);
    PlotFisher(w, male_data, female_data, test_data(1:10, :), test_data(11:20, :));
    legend('male training', 'female training', 'male test', 'female test', 'boundary');
    
    % method II: project face into lower dimensional spaces by PCA
    all_face = [male_data; female_data];
    [mean_face, U, D] = myPCA(all_face);
    new_d = 50;
    lowD_male_face = ProjectNewDim_PCA(mean_face, male_data, U, new_d);
    lowD_female_face = ProjectNewDim_PCA(mean_face, female_data, U, new_d);
    
    w = LowD_Fisher(lowD_male_face, lowD_female_face);
    lowD_test_data = ProjectNewDim_PCA(mean_face, test_data, U, new_d);
    PlotFisher(w, lowD_male_face, lowD_female_face, lowD_test_data(1:10, :), lowD_test_data(11:20, :));
    legend('male training', 'female training', 'male test', 'female test', 'boundary');
end