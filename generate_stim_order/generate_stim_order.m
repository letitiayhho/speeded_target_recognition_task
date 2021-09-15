function generate_stim_order(subject_number)
    cd '/Users/letitiaho/src/speeded_vowel_identification/generate_stim_order/'
    addpath('functions')
    subject_number = str2num(subject_number);

    % SET SEED
    rng(subject_number)

    % Get talker order
    [type, talker] = get_talker_order();

    % Get vowel order
    [vowel, istarget] = get_vowel_order();

    % Block 
    block_length = [1, 5, 16, 16, 16, 16];
    block = [];
    rep = [];
    utterance = [];
    for i = 1:length(block_length)
        block = [block, repmat(i, 1, block_length(i)*16)];
        for j = 1:block_length(i)
            rep = [rep, repmat(j, 1, 16)];
            utterance = [utterance, (1:16)];
        end
    end

    % Subject
    subject = repmat(subject_number, 1, length(type));

    % COLUMNS: subject, block, type, rep, utterance, vowel, istarget, talker
    stim_order = table(subject, block, type, rep, utterance, vowel, istarget, talker);

    % WRITE
    writetable(stim_order, ['output/', num2str(subject_number), '_stim_order.txt'])
end