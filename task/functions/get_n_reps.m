function [n_reps] = get_n_reps(stim_order, block)
    stim_order = stim_order(stim_order.block == block, :);
    n_reps = max(stim_order.utterance);
end