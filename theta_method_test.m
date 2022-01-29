function [] = theta_method_test()
    simulate_system_1();
    simulate_system_2();
end

function [] = simulate_system_1()
    test_case_count = 6;

    thetas = [0, 0, 0.5, 0.5, 1.0, 1.0];
    y_init = [1; 2];
    time_interval = [0, 1];
    timestep_sizes = [0.01, 0.05, 0.01, 0.05, 0.01, 0.05];
    
    f = @(t, y) [-1, 0; 0, -100]*y + [0; 100*sin(t)+cos(t)];
    f_jacobian = @(t, y) [-1, 0; 0, -100];
    
    for k = 1 : test_case_count
        try
            [points, timesteps] = theta_method(f, f_jacobian, thetas(k), y_init, time_interval, timestep_sizes(k));
            plot_test_case_results(1, k, points, timesteps, timestep_sizes(k), thetas(k));
        catch ME
            fprintf("Error in System 1 Test Case %03d: %s\n", k, ME.identifier);
        end
    end
end

function [] = simulate_system_2()
    test_case_count = 6;

    thetas = [0, 0, 0.5, 0.5, 1.0, 1.0];
    y_init = [10; 10];
    time_interval = [0, 100];
    timestep_sizes = [0.1, 0.001, 0.1, 0.001, 0.1, 0.001];
    
    f = @(t, y) [0.25, 0; 0, -1]*y + 0.01*y(1)*y(2)*[-1; 1];
    f_jacobian = @(t, y) [-1, 0; 0, -100];
    
    for k = 1 : test_case_count
        try
            [points, timesteps] = theta_method(f, f_jacobian, thetas(k), y_init, time_interval, timestep_sizes(k));
            plot_test_case_results(2, k, points, timesteps, timestep_sizes(k), thetas(k));
        catch ME
            fprintf("Error in System 2 Test Case %03d: %s\n", k, ME.identifier);
        end
    end
end

function [] = plot_test_case_results(system_id, test_case_id, points, timesteps, timestep_size, theta)
    title_phase_portrait = sprintf("y_1 vs. y_2 (h = %.2f, theta = %.2f)", timestep_size, theta);
    file_name_phase_portrait = sprintf("phase_portrait_%03d_%03d.png", system_id, test_case_id);
    plot_phase_portrait(points, title_phase_portrait, file_name_phase_portrait);

    title_y1_vs_t = sprintf("y_1 vs. t (h = %.2f, theta = %.2f)", timestep_size, theta);
    file_name_y1_vs_t = sprintf("y1_vs_t_%03d_%03d.png", system_id, test_case_id);
    plot_y_vs_time(points, 1, timesteps, title_y1_vs_t, file_name_y1_vs_t);

    title_y2_vs_t = sprintf("y_2 vs. t (h = %.2f, theta = %.2f)", timestep_size, theta);
    file_name_y2_vs_t = sprintf("y2_vs_t_%03d_%03d.png", system_id, test_case_id);
    plot_y_vs_time(points, 2, timesteps, title_y2_vs_t, file_name_y2_vs_t);
end

function [] = plot_phase_portrait(points, plot_title, file_name)
    phase_portrait = plot(points(1,:), points(2,:)); 
    title(plot_title);
    xlabel("y_1");
    ylabel("y_2");
    saveas(phase_portrait, file_name);
end

function [] = plot_y_vs_time(points, y_coor_index, timesteps, plot_title, file_name)
    phase_portrait = plot(timesteps, points(y_coor_index,:));
    title(plot_title);
    xlabel("t");
    ylabel(sprintf("y_%d", y_coor_index));
    saveas(phase_portrait, file_name);
end
