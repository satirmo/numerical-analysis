function [y, timesteps] = forward_euler(f, t_init, y_init, t_max, h)
    timesteps = t_init : h : t_max;
    y = zeros(2, numel(timesteps));
    y(:,1) = y_init;

    for k = 1 : numel(timesteps)-1
        y(:,k+1) = y(:,k) + h * f(timesteps(k), y(:,k));
    end
end
