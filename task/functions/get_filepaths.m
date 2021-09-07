function [fullpath] = get_filepaths(stim_order, block, rep)
    stim_order = stim_order(stim_order.block == block, :);
    stim_order = stim_order(stim_order.rep == rep, :);
    fullpath = fullfile('stim', stim_order.talker, stim_order.vowel + ".wav");
end