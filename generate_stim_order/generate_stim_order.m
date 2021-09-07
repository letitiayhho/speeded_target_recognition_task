cd '/Users/letitiaho/src/speeded_vowel_identification/generate_stim_order/'
addpath('functions')
subject_number = 0;

% SET SEED
rng(subject_number)

% Get talker order
[type, talker] = get_talker_order(subject_number);

% Get vowel order
[vowel, istarget] = get_vowel_order();

% Block 
block_length = [1, 5, 16, 16, 16, 16];
block = [];
rep = [];
utterance = [];
for i = 1:length(block_length)
    block = [block; repmat(i, block_length(i)*16, 1)];
    for j = 1:block_length(i)
        rep = [rep; repmat(j, 16, 1)];
        utterance = [utterance; (1:16)'];
    end
end

% Subject
subject = repmat(subject_number, length(type), 1);

% COLUMNS: subject, block, type, rep, utterance, vowel, istarget, talker
stim_order = table(subject, block, type, rep, utterance, vowel, istarget, talker);

% WRITE
writetable(stim_order, ['output/', num2str(subject_number), '_stim_order.txt'])