function [x] = calculate_stability_test()
    test_case_count = 4;

    test_matrices = cell(test_case_count, 1);
    test_matrices{1} = [-5, 0; 0, 1];
    test_matrices{2} = [-1, -1; 1, 1];
    test_matrices{3} = [-1, 10; 0, -2];
    test_matrices{4} = [0, -1; 5, 0];

    expected = ["unstable", "asymptotically stable", "asymptotically stable", "stable"];

    for k = 1 : test_case_count
        if expected(k) == calculate_stability(test_matrices{k})
            test_result = "Success";
        else
            test_result  = "Failed";
        end

        fprintf("Test Case %03d: %s\n", k, test_result);
    end
end
