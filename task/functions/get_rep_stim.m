function [vowels, paths, target, istarget] = get_filepaths(stim_order, block, rep)
    % subset by block and rep
    stim_order = stim_order(stim_order.block == block, :);
    stim_order = stim_order(stim_order.rep == rep, :);
    
    % get details
    vowels = char(stim_order.vowel);
    paths = fullfile('stim', stim_order.talker, stim_order.vowel + ".wav");
    target = char(unique(stim_order.vowel(logical(stim_order.istarget))));
    istarget = stim_order.istarget;
end