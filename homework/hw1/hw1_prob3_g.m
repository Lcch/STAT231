function [ output_args ] = hw1_prob3_g( mu_1, sigma_1, mu_2, sigma_2)
    g_1 = sprintf('1/(%f * sqrt(2 * pi)) * exp(-(x-%f)^2/(2*%f^2))', sigma_1, mu_1, sigma_1);
    g_2 = sprintf('1/(%f * sqrt(2 * pi)) * exp(-(x-%f)^2/(2*%f^2))', sigma_2, mu_2, sigma_2);
    
    figure();
    strcat(g_1, '/(', g_1, '+', g_2, ')')
    line1 = ezplot(g_1, [-20, 20, 0, 0.001]);
    set(line1,'color', 'b')
    hold on;
    line2 = ezplot(g_2, [-20, 20, 0, 0.001]);
    set(line2, 'color', 'r');
    legend('p(x|y=-1)', 'p(x|y=+1)')
    
    %-----------------Roc------------
    figure();
    x = 20:-0.1:-10
    tp = normcdf(x, mu_1, sigma_1)
    fp = normcdf(x, mu_2, sigma_2)
    plot(fp, tp)
    
    %-----------------PR------------
    figure();
    fn = 1.0 - tp;
    plot(tp ./ (tp + fn), tp ./ (fp + tp));
    
    %-----for homework
    
    figure();
    x = 20:-0.01:-10
    tp = normcdf(x, 2.0, 5.0)
    fp = normcdf(x, 6.0, 4.0)
    plot(fp, tp, 'r')
    hold on;
    tp = normcdf(x, 2.0, 5.0)
    fp = normcdf(x, 4.0, 4.0)
    plot(fp, tp, 'b')
    legend('mu2=6.0', 'mu2=4.0')
    
    figure();
    tp = normcdf(x, 2.0, 5.0) * 0.44
    fp = normcdf(x, 6.0, 4.0) * 0.56
    fn = 0.44 - tp;
    plot(tp ./ (tp + fn), tp ./ (fp + tp), 'r');
    axis([0 1 0 1]);
    hold on;
    tp = normcdf(x, 2.0, 5.0) * 0.44
    fp = normcdf(x, 4.0, 4.0) * 0.56
    fn = 0.44 - tp;
    plot(tp ./ (tp + fn), tp ./ (fp + tp), 'b');
    axis([0 1 0 1]);
    legend('mu2=6.0', 'mu2=4.0')
end

