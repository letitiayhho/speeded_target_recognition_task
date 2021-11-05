function target_order = choose_target_order(n_trials)
    possible_targets = ["AA", "EH", "IH" "OO"];
    target_order = [];
    for i = 1:round(n_trials/length(possible_targets))
        target_order = [target_order; datasample(possible_targets, 4, 'Replace', false)'];
    end
    target_order = target_order(1:n_trials);
end