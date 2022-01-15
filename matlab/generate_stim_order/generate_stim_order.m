function [stim_order, n_trials]  = generate_stim_order(subject_number, block, variation)
    arguments
        subject_number double
        block double
        variation {mustBeMember(variation,["male","exemplar","NaN"])} = "NaN"
    end

    addpath('generate_stim_order/functions')
    
    % SET SEET
    rng(subject_number)
    
    % Get block type
    [vowel_space, blocked, talkers, n_trials] = get_block_type(block, variation); 
    
    % SET SEED to randomize trials within blocks
    seed = str2double(strcat(num2str(subject_number), num2str(block)));
    rng(seed)

    % Get talker order
    [talker] = get_talker_order(vowel_space, blocked, talkers, n_trials);

    % Get vowel order
    [vowel, istarget] = get_vowel_order(n_trials);
    
    % Get exemplar order
    exemplar = get_exemplar_order(n_trials*16, variation);

    % Block 
    block = repmat(block, n_trials*16, 1);
    vowel_space = repmat(vowel_space, n_trials*16, 1); % CHANGE
    blocked = repmat(blocked, n_trials*16, 1);
    trial = repmat(1:n_trials, 16, 1);
    trial = reshape(trial, size(trial, 1)*size(trial, 2), 1);
    token = repmat((1:16)', n_trials, 1);

    % Subject
    subject = repmat(subject_number, n_trials*16, 1);

    % CREATE TABLE
    stim_order = table(subject, block, vowel_space, blocked, trial,...
        token, vowel, talker, exemplar, istarget);
end