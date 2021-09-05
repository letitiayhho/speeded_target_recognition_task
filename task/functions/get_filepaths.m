function [fullpath, vowel] = get_filepaths(stim_order)
    fullpath = fullfile('stim', stim_order.talker, stim_order.vowel + ".wav");
    vowel = stim_order.vowel;
end