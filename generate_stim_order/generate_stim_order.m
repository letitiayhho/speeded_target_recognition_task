function [stim_order, n_trials]  = generate_stim_order(subject_number, block)
    addpath('generate_stim_order/functions')
    
    % SET SEET
    rng(subject_number)
    
    % Get block type
    [block_type, n_trials] = get_block_type(block); 
    
    % SET SEED to randomize trials within blocks
    seed = str2double(strcat(num2str(subject_number), num2str(block)));
    rng(seed)

    % Get talker order
    [trial_type, talker, n_trials] = get_talker_order(block_type, n_trials);

    % Get vowel order
    [vowel, istarget] = get_vowel_order(n_trials);
    
    % Get exemplar order
    exemplar = get_exemplar_order(n_trials*16);

    % Block 
    block = repmat(block, n_trials*16, 1);
    block_type = repmat(block_type, n_trials*16, 1);
    trial = repmat(1:n_trials, 16, 1);
    trial = reshape(trial, size(trial, 1)*size(trial, 2), 1);
    token = repmat((1:16)', n_trials, 1);

    % Subject
    subject = repmat(subject_number, n_trials*16, 1);

    % CREATE TABLE
    stim_order = table(subject, block, block_type, trial, trial_type,...
        token, vowel, talker, exemplar, istarget);
end