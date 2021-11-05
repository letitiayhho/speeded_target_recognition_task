function [talker_order] = get_talker_order(vowel_space, blocked, talkers, n_trials)
    talker_order = [];
    vowel_space_order = repmat(vowel_space, 16*8, 1);
    blocked_order = repmat(blocked, 16*8, 1);

    % Broadcast talker selection for each trial into each utterance
    if strcmp(blocked, "b")
        talker_order = repmat(talker, 128, 1);
    elseif strcmp(blocked, "m")
        for i = 1:n_trials
            talker1 = string(talkers(1));
            talker2 = string(talkers(2));
            sample = repmat([talker1, talker2], 1, 8);
            talker_order = [talker_order; datasample(sample, 16, 'Replace', false)'];
        end
    elseif strcmp(blocked, "training")
        mixed_AB = repmat(["A", "B"], 1, 8)';
        mixed_XY = repmat(["X", "Y"], 1, 8)';
        talker_order = [repmat("A", 1, 16); repmat("X", 1, 16); mixed_AB;...
            repmat("Y", 1, 16); mixed_XY; repmat("B", 1, 16)];
    end
end