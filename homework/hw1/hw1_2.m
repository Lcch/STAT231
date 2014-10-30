function [] = hw1_2(  )
    g_1 = '(exp(-((x1-12)^2+(x2-3)^2)/18)/(5*pi) + exp(-((x1-3)^2+(x2-5)^2)/18)/(15*pi))';
    g_2 = '(exp(-((x1-4)^2+(x2-12)^2)/18)*2/(15*pi) + exp(-((x1-3)^2+(x2-5)^2)/18)/(30*pi))';
    g_3 = '(exp(-((x1-4)^2+(x2-12)^2)/18)/(5*pi) + exp(-((x1-12)^2+(x2-3)^2)/18)/(15*pi))';

    line1 = ezplot(strcat(g_1, '-', g_2), [0, 18, 0, 18]);
    set(line1,'color', 'r')
    hold on;
    line2 = ezplot(strcat(g_1, '-', g_3), [0, 18, 0, 18]);
    set(line2,'color', 'g')
    hold on;
    line3 = ezplot(strcat(g_2, '-', g_3), [0, 18, 0, 18]);
    set(line3,'color', 'b')
    legend('g1(x)=g2(x)', 'g1(x)=g3(x)', 'g2(x)=g3(x)')
end
