function [verdict] = calculate_stability(A)
    eigenvals = eig(A);
    verdict = "";

    if is_unstable(eigenvals)
        verdict = "unstable";
    elseif is_asymptotically_stable(eigenvals)
        verdict = "asymptotically stable";
    elseif is_stable(eigenvals)
        verdict = "stable";
    end
end

function [result] = is_unstable(eigenvals)
    real_parts = real(eigenvals);
    result = false;

    for k = 1 : numel(real_parts)
        if real_parts(k) > 0
            result = true;
        end
    end
end

function [result] = is_stable(eigenvals)
    real_parts = real(eigenvals);
    unique_eigenvals = unique(eigenvals);
    result = true;

    for k = 1 : numel(real_parts)
        if real_parts(k) > 0
            result = false;
        end

        if and(real_parts(k) == 0, not(any(unique_eigenvals == eigenvals(k))))
            result = false;
        end
    end
end

function [result] = is_asymptotically_stable(eigenvals)
    real_parts = real(eigenvals);
    result = true;

    for k = 1 : numel(real_parts)
        if real_parts(k) >= 0
            result = false;
        end
    end
end
