function [n_trials] = get_n_trials(stim_order, block)
    stim_order = stim_order(stim_order.block == block, :);
    n_trials = max(stim_order.token);
end