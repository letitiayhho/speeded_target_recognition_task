function [talker_order] = get_talker_order(vowel_space, blocked, talkers, n_trials)
%     [talkers] = get_block_talkers(vowel_space, blocked);   

%     talker = [];
%     trial_type = [];
% 
    % Generate trial talkers and order
%     if strcmp(block_type, "training")
%             talker = ["A", "A"; "A", "B"; "X", "X"; "X", "Y"];
%             trial_type = ["b"; "m"; "b"; "m"];
%     else
%     for i = 1 :round(n_trials/length(talkers))
%         order = randperm(length(talkers));
%         talker = [talker; talkers(order, :)]; % select pairing for each trial
%         trial_type = [trial_type; trial_types(order)];
%     end
%     end

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
    end
            
%     for j = 1:n_trials
% %         if strcmp(trial_type(j), 'b')
% %             talker_order = [talker_ order; repmat(talker(j, 1), 16, 1)];
% %         else
%             while true
%                 utterances = datasample(talker(j, :), 16)';
%                 if check_repeats(utterances, 3)
%                     break
%                 end
%             end
%             talker_order = [talker_order; utterances];
%         end
%     end
end