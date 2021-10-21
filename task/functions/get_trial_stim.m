function [vowel, path, istarget, target, trial_type] = get_trial_stim(stim_order, trial)
    % subset by block and trial
    stim_order = stim_order(stim_order.trial == trial, :);
    
    % get details
    vowel = char(stim_order.vowel);
    path = fullfile('stim', stim_order.talker, stim_order.vowel + stim_order.exemplar + ".wav");
    istarget = stim_order.istarget;
    target = char(unique(stim_order.vowel(logical(stim_order.istarget))));
    trial_type = unique(stim_order.trial_type);
end