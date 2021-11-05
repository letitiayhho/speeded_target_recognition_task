function [vowel_space, blocked, n_trials] = get_block_type(BLOCK)
    talkers = {'A', 'B', 'AB', 'AB', 'X', 'Y', 'XY', 'XY'};
    vowel_space = ["b", "b", "m", "m", "b", "b", "m", "m"];
    blocked = ["s", "s", "s", "s", "d", "d", "d", "d"];
    
    % Randomize order
    indexes = randperm(8);
    talkers = talkers(indexes);
    vowel_space = vowel_space(indexes);
    blocked = blocked(indexes);

    % Get values for this block
    talkers = char(talkers(BLOCK));
    vowel_space = vowel_space(BLOCK);
    blocked = blocked(BLOCK);
    n_trials = [6, 8, 8, 8, 8, 8, 8, 8, 8];
    n_trials = n_trials(BLOCK);
    
    % training
    if BLOCK == 1
        talkers = "training";
        vowel_space = "training";
        blocked = "training";
    end
end