function [stim_order, n_trials, trial_type, target_key]  = generate_stim_order(subject_number, block)
    addpath('generate_stim_order/functions')

    % SET SEED
    rng(subject_number)
    
    % Get same key
    target_key = get_target_key();
    
    % SET SEED for different blocks
    seed = str2double(strcat(num2str(subject_number), num2str(block)));
    rng(seed)

    % Get talker order
    [block_type, trial_type, talker, n_trials] = get_talker_order(block);

    % Get vowel order
    [vowel, istarget, key] = get_vowel_order(n_trials, target_key);
    
    % Get exemplar order
    exemplar = get_exemplar_order(n_trials*16);

    % Block 
    block = repmat(block, n_trials*16, 1);
    trial = repmat(1:n_trials, 16, 1);
    trial = reshape(trial, size(trial, 1)*size(trial, 2), 1);
    rep = repmat((1:16)', n_trials, 1);

    % Subject
    subject = repmat(subject_number, n_trials*16, 1);

    % CREATE TABLE
    stim_order = table(subject, block, block_type, trial, trial_type,...
        rep, vowel, talker, exemplar, istarget, key);
end