function [] = forward_euler_test()
    test_case_count = 3;
    t_init = [0, 0, 0];
    y_init = [1, 2; 1, 2; 1, 2];
    t_max = [1, 1, 0.2];
    h = [0.01, 0.05, 0.05];

    for k = 1 : test_case_count
        points = forward_euler(@f, t_init(k), y_init(k), t_max(k), h(k));
        fig = plot(points(:,1), points(:,2));

        title(sprintf("Forward Euler: h = %.2f", h(k)))
        xlabel("y_1")
        ylabel("y_2")
        saveas(fig, sprintf("forward_euler_%03d.png", k));
    end
end

function [result] = f(t, y)
    result = [-y(1), -100 * (y(2) - sin(t)) + cos(t)];
end
