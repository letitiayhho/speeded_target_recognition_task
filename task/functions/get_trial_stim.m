function [vowel, path, trial_type, target, istarget] = get_trial_stim(stim_order, block, trial)
    % subset by block and trial
    stim_order = stim_order(stim_order.block == block, :);
    stim_order = stim_order(stim_order.trial == trial, :);
    
    % get details
    vowel = char(stim_order.vowel);
    path = fullfile('stim', stim_order.talker, stim_order.vowel + stim_order.exemplar + ".wav");
    trial_type = stim_order.trial_type;
    target = char(unique(stim_order.vowel(logical(stim_order.istarget))));
    istarget = stim_order.istarget;
end