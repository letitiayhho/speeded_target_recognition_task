cd '/Users/letitiaho/src/speeded_vowel_identification/generate_stim_order/'
addpath('functions')
subject_number = 22341;

% SET SEED
rng(subject_number)

% Get talker order
[block_type, talker] = get_talker_order(subject_number);

% Get vowel order
[vowel_order, istarget] = get_vowel_order();











% n_reps = [4, 16, 16, 16, 16];
% n_talkers = 12;


% BLOCK_TYPE = ["training", "blocked", "mixed", "blocked", "mixed"];
% REP_TYPE = ["f1f2", "m1m2", "f1m1", "f2m2"];

% block
% block_type
% rep_type
% REP
% utterance
% vowel
% istarget
% talker

% for BLOCK = 1:length(n_reps)
%     for REP = 1:n_reps(i)
% %             for UTTERANCE = 1:16
%         block = [block, BLOCK]
%         rep = [rep, REP]
%         utterance = [utterance, 1:16]
%         block_type = [block_type, BLOCK_TYPE(BLOCK)];
%         rep_type = opts(randi(length(opts), 1, 1))
%         
%     end
% end