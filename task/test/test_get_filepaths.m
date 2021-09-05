cd  /Users/letitiaho/src/speeded_vowel_identification/
stim_order = readtable('generate_stim_order/output/stim_paths.txt', 'TextType', 'char');

fullpath = fullfile('stim', stim_order.talker, stim_order.vowel + ".wav")
vowel = stim_order.vowel