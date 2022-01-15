function [vowel_space, blocked, talkers, n_trials] = get_block_type(BLOCK, variation)
    arguments
        BLOCK double
        variation {mustBeMember(variation,["male","NaN"])} = "NaN"
    end
    
    if strcmp(variation, "male") % replace X because X has the worst recordings
        talkers = ["A", "B", "AB", "AB", "M", "Y", "MY", "MY"];
    else
        talkers = ["A", "B", "AB", "AB", "X", "Y", "XY", "XY"];
    end
    
    vowel_space = ["s", "s", "s", "s", "d", "d", "d", "d"];
    blocked = ["b", "b", "m", "m", "b", "b", "m", "m"];
    
    % Randomize order
    indexes = randperm(8);
    talkers = talkers(indexes);
    vowel_space = vowel_space(indexes);
    blocked = blocked(indexes);
    
    % Add training
    talkers = ["training", talkers];
    vowel_space = ["training", vowel_space];
    blocked = ["training", blocked];

    % Get values for this block
    talkers = char(talkers(BLOCK));
    vowel_space = vowel_space(BLOCK);
    blocked = blocked(BLOCK);
    n_trials = [6, 8, 8, 8, 8, 8, 8, 8, 8];
    n_trials = n_trials(BLOCK);
end