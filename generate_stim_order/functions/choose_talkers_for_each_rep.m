function [rep_talkers] = choose_talkers_for_each_rep()
    male_talkers = ["m1", "m2", "m3"];
    female_talkers = ["f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9"];

    % Generate blocked talker sequence
    blocked = randomize_talker([male_talkers, female_talkers], 32);
    blocked = [blocked, blocked, repmat('b', 32, 1)];

    % Generate mixed talker sequence
    [mf1, mf2] = randomize_male_female_talker_pairs(male_talkers, female_talkers, 16);
    [ff1, ff2] = randomize_female_female_talker_pairs(female_talkers, 16);
    mixed = [mf1, mf2, repmat('mf', 16, 1); ff1, ff2, repmat('ff', 16, 1)];
    mixed = mixed(randperm(length(mixed)), :);

    % Pick order of blocks
    block_types = struct('blocked', blocked, 'mixed', mixed);
    if rand < 0.5
        block_order = ["blocked", "mixed", "blocked", "mixed"];
    else
        block_order = ["mixed", "blocked", "mixed", "blocked"];
    end

    % Generate final talker order
    rep_talkers = [block_types.(block_order(1))(1:16, :);...
        block_types.(block_order(2))(1:16, :);...
        block_types.(block_order(3))(17:32, :);...
        block_types.(block_order(4))(17:32, :)];
    
    function [seq] = randomize_talker(talkers, n_trials)
        n_talkers = length(talkers);
        passes = floor(n_trials/n_talkers);
        remainder = mod(n_trials, n_talkers);
        seq = [];
        for i = 1:passes
            seq = [seq, talkers(randperm(n_talkers))];
        end
        seq = [seq, talkers(randperm(n_talkers, remainder))];
        seq = seq';
    end

    function [seq1, seq2] = randomize_male_female_talker_pairs(male_talkers, female_talkers, n_trials)
        seq1 = randomize_talker(male_talkers, n_trials);
        seq2 = randomize_talker(female_talkers, n_trials);
    end

    function [seq1, seq2] = randomize_female_female_talker_pairs(female_talkers, n_trials)
        duplicates = true;
        while duplicates
            seq1 = randomize_talker(female_talkers, n_trials);        
            seq2 = randomize_talker(female_talkers, n_trials);
            if sum(seq1 == seq2) == 0
                duplicates = false;
            end
        end
    end
end