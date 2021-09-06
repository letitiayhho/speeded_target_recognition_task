function target_order = choose_target_for_each_rep()
    possible_targets = ["IH", "OO", "UH"];
    target_order = datasample(possible_targets, 64);
end