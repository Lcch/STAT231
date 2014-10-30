function [ ] = PlotFisher(w, male_data, female_data, male_test, female_test)
    % plot fisher results
    m_m = mean(male_data);
    m_f = mean(female_data);
    boundary_value = (w' * m_m' + w' * m_f') / 2.0;
    
    figure();
    for i = 1 : size(male_data, 1)
        male_point(i) = w' * male_data(i, :)';
    end
    plot(male_point, 'b+');
    hold on;
    for i = 1 : size(female_data, 1)
        female_point(i) = w' * female_data(i, :)';
    end
    plot(female_point, 'r+');
    hold on;
    for i = 1 : size(male_test, 1)
        male_test_point(i) = w' * male_test(i, :)';
    end
    plot(male_test_point, 'bo');
    hold on;
    for i = 1 : size(female_test, 1)
        female_test_point(i) = w' * female_test(i, :)';
    end
    plot(female_test_point, 'ro');
    hold on;
    plot(ones(1, 80) * (boundary_value), 'yellow');
end