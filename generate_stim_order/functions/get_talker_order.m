function [block_type, trial_type_order, talker_order, n_trials] = get_talker_order(block)
    [block_type, n_trials] = get_block_type(block); 
    [talkers, trial_types] = get_block_talkers(block_type);   

    talker = [];
    trial_type = [];

    % Generate trial talkers and order
    if strcmp(block_type, "training")
            talker = ["A","A"; "A", "B"; "X", "X"; "X", "Y"];
            trial_type = ["b"; "m"; "b"; "m"];
    else
        for i = 1:round(n_trials/length(talkers))
            order = randperm(length(talkers));
            talker = [talker; talkers(order, :)]; % select pairing for each trial
            trial_type = [trial_type; trial_types(order)];
        end
    end

    talker_order = [];
    trial_type_order = [];

    % Broadcast talker selection for each trial into each utterance
    for j = 1:length(talker)
        trial_type_order = [trial_type_order; repmat(trial_type(j), 16, 1)];
        if strcmp(trial_type(j), 'b')
            talker_order = [talker_order; repmat(talker(j, 1), 16, 1)];
        else
            while true
                utterances = datasample(talker(j, :), 16)';
                if check_repeats(utterances)
                    break
                end
            end
            talker_order = [talker_order; utterances];
        end
    end
    
    % Don't allowed 4 consecutive utterances by the same talker
    function [cont] = check_repeats(seq)
        for k = 1:length(seq)-3
            window = k:k+3;
            if length(unique(seq(window))) == 1
                % returns false if 3 consecutive stim are by the same
                % talker
                cont = false;
                return
            end
        end
        cont = true;
    end
end