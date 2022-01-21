function [result] = calculate_stability(system_matrix, eps)
    if nargin == 1
        eps = 1e-8;
    end
    
    eigenvals = eig(system_matrix);
    result = "unstable";

    if norm(eigenvals) < eps
        eigenvals = zeros(size(eigenvals));
    end

    if is_asymptotically_stable(eigenvals)
        result = "asymptotically stable";
    elseif is_stable(system_matrix, eigenvals)
        result = "stable";
    end
end

function [result] = is_asymptotically_stable(eigenvals)
    real_parts = real(eigenvals);
    result = true;

    for k = 1 : numel(real_parts)
        if real_parts(k) >= 0
            result = false;
            break;
        end
    end
end

function [result] = is_stable(system_matrix, eigenvals)
    zero_matrix = zeros(size(system_matrix));
    identity_matrix = eye(size(system_matrix));
    
    real_parts = real(eigenvals);
    result = true;

    for k = 1 : numel(real_parts)
        if real_parts(k) > 0
            result = false;
            break;
        end

        algebraic_multiplicity = length(find(eigenvals == eigenvals(k)));

        if and(real_parts(k) == 0, algebraic_multiplicity > 1)
            if system_matrix - eigenvals(k)*identity_matrix ~= zero_matrix
                result = false;
                break;
            end
        end
    end
end
