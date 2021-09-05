cd  /Users/letitiaho/src/speeded_vowel_identification/
stim_order = readtable('generate_stim_order/output/stim_order.txt');

fullpath = fullfile('stim', stim_order.talker, stim_order.vowel + ".wav")
vowel = stim_order.vowel