function [ output_args ] = hw1_prob3( input_args )
    g_1 = '1/(4.0 * sqrt(2 * pi)) * exp(-(x-6.0)^2/(2*4.0^2)) * 0.56';
    g_2 = '1/(5.0 * sqrt(2 * pi)) * exp(-(x-2.0)^2/(2*5.0^2)) * 0.44';
    
    strcat(g_1, '/(', g_1, '+', g_2, ')')
    line1 = ezplot(strcat(g_1, '/(', g_1, '+', g_2, ')'), [-20, 40, 0, 1]);
    set(line1,'color', 'b')
    hold on;
    line2 = ezplot(strcat(g_2, '/(', g_1, '+', g_2, ')'), [-20, 40, 0, 1]);
    set(line2, 'color', 'r');
    legend('p(y=+1|x)', 'p(y=-1|x)')
end

