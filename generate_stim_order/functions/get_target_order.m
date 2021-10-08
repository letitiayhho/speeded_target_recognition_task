function target_order = choose_target_order()
    possible_targets = ["AA", "EH", "IH" "OO"];
    target_order = [];
    for i = 1:24
        target_order = [target_order, datasample(possible_targets, 3, 'Replace', false)];
    end
    target_order = target_order(1:70);
end