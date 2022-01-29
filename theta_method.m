function [y, timesteps] = theta_method(f, f_jacobian, theta, y_init, time_interval, timestep_size, tol_newton, max_iterations_newton)
    if nargin == 6
        tol_newton = 1e-8;
    end

    if nargin <= 7
        max_iterations_newton = 1000;
    end

    h = timestep_size;
    timesteps = time_interval(1): timestep_size : time_interval(2);

    y_dim = size(y_init, 1);
    y = zeros(y_dim, numel(timesteps));
    y(:,1) = y_init;

    G = @(t_prev, y_prev, t_curr, y_curr) y_curr - y_prev - h*((1-theta)*f(t_curr, y_curr) + theta*f(t_prev, y_prev));
    G_jacobian = @(t, y) eye(y_dim) - h*(1-theta)*f_jacobian(t, y);

    for k = 2 : numel(timesteps)
        y(:,k) = newton_method(timesteps(k-1), y(:,k-1), timesteps(k), G, G_jacobian, tol_newton, max_iterations_newton);
    end
end

function [est_curr] = newton_method(t_prev, y_prev, t_curr, G, G_jacobian, tol_newton, max_iterations_newton)
    error_curr = 1e100;
    est_curr= y_prev;

    for k = 1 : max_iterations_newton
        if error_curr < tol_newton
            return
        end

        est_prev = est_curr;
        delta = linsolve(G_jacobian(t_curr, est_prev), -G(t_prev, y_prev, t_curr, est_prev));
        est_curr = est_prev + delta;

        error_curr = norm(est_curr - est_prev);
    end

    error_id = "NewtonMethod:NoConvergence";
    message = sprintf("The Newton Method did not converge for tol_newton = %f and max_iterations = %d\n", tol_newton, max_iterations_newton);
    throw(MException(error_id, message));
end
