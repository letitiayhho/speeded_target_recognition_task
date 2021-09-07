function [block_type, talker] = get_talker_order()
    rep_talkers = choose_talkers_for_each_rep();
    
    % Broadcast the chosen talkers for each rep into 16 trials
    talker = [];
    block_type = [];
    for i = 1:length(rep_talkers)
        block_type = [block_type; repmat(rep_talkers(i, 3), 16, 1)];
        talker = [talker; datasample(rep_talkers(i, 1:2), 16)'];
    end
end