function [talker_order] = get_talker_order(vowel_space, blocked, talkers, n_trials, version)
    arguments
        vowel_space string
        blocked string
        talkers char
        n_trials double
        version {mustBeMember(version,["male","exemplar","NaN"])} = "NaN"
    end
    
    talker_order = [];
    vowel_space_order = repmat(vowel_space, 16*8, 1);
    blocked_order = repmat(blocked, 16*8, 1);

    % Broadcast talker selection for each trial into each utterance
    if strcmp(blocked, "b")
        talker_order = repmat(talkers, 128, 1);
    elseif strcmp(blocked, "m")
        i = 0;
        while i < n_trials
            talker1 = string(talkers(1));
            talker2 = string(talkers(2));
            sample = repmat([talker1, talker2], 1, 8);
            trial = datasample(sample, 16, 'Replace', false)';
            % Make sure there aren't more than 4 same or different trials in a row
            if check_repeats(trial)
                continue
            end
            talker_order = [talker_order; trial];
            i = i + 1;
        end
    elseif strcmp(blocked, "training")
        if strcmp(version, "male")
            talker2 = "M";
        else
            talker2 = "X";
        end
        
        while true
            mixed_AB = datasample(["A", "B"], 16)';
            mixed_XY = datasample([talker2, "Y"], 16)';
            if check_repeats(mixed_AB) && check_repeats(mixed_XY)
                break
            end
        end
        talker_order = [repmat("A", 1, 16)'; repmat(talker2, 1, 16)'; mixed_AB;...
            repmat("Y", 1, 16)'; mixed_XY; repmat("B", 1, 16)'];
    end
    
    function save = check_repeats(seq)
        for j = 1:length(seq)-4
            window = j:j+4;
            counts = groupcounts(seq(window));
            if sum(counts >= 4) > 0
                % Generate talker order recursively until condition is met
                save = false;
                return
            end
        end
        save = true;
    end
end