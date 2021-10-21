function [stim_order, path, istarget, target] = get_trial_stim(stim_order, trial)
    % subset by block and trial
    stim_order = stim_order(stim_order.trial == trial, :);
    
    % get details
    path = fullfile('stim', stim_order.talker, stim_order.vowel + stim_order.exemplar + ".wav");
    istarget = stim_order.istarget;
    target = char(unique(stim_order.vowel(logical(stim_order.istarget))));
end