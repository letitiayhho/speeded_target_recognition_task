function [fullpath] = get_filepaths(stim_order)
    fullpath = fullfile('stim', stim_order.talker, stim_order.vowel + ".wav");
end