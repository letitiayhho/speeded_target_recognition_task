function [stim_order, n_trials, trial_type, target_key]  = generate_stim_order(subject_number, block)
    addpath('generate_stim_order/functions')

    % SET SEED
    rng(subject_number)

    % Get talker order
%         [talker1, talker2, same, key, n_trials, same_key, block_type] = get_talker_order(block);
    [block_type, trial_type, talker, istarget,...
        key, target_key, n_trials] = get_talker_order(block);

    % Get vowel order
    [vowel, istarget, key, target_key] = get_vowel_order(n_trials);
    
    % Get exemplar order
    exemplar = get_exemplar_order(n_trials);

    % Block 
    block = repmat(block, n_trials, 1);
    rep = (1:n_trials)';

    % Subject
    subject = repmat(subject_number, n_trials, 1);

    % CREATE TABLE
    stim_order = table(subject, block, block_type, trial_type, rep, utterance,...
        vowel, talker, exemplar, istarget, key);

    % WRITE
%     writetable(stim_order, ['output/', num2str(subject_number), '_stim_order.txt'])
end